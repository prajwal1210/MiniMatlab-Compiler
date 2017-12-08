#include "ass5_15CS30043_translator.cxx"
#include <sstream>
#include <bits/stdc++.h>
map<int,string> labels;
int funcno = 0; 
int paramno = 0;
int labelnum = 0;
vector<string> params;
int paramindex=0;

void makeLabels(quadArray* quads)
{
    int size = quads->quadarray.size();
    for(int i=0;i<size;i++)
    {
        if( quads->quadarray[i].op == "if<" 
        ||  quads->quadarray[i].op == "if>"
        ||  quads->quadarray[i].op == "if<="
        ||  quads->quadarray[i].op == "if>="
        ||  quads->quadarray[i].op == "if=="
        ||  quads->quadarray[i].op == "if!="
        ||  quads->quadarray[i].op == "if"
        ||  quads->quadarray[i].op == "goto"   
        )
        {
            stringstream ss(quads->quadarray[i].res);
            int x; 
            ss >> x;
            ostringstream s1; 
            s1 << labelnum;
            labels[x] = ".L" + s1.str(); 
            labelnum++;
        }
    }
}

void staticdata(ofstream &foutasm)
{
    foutasm << "\t.section\t.rodata\n";
    for (std::map<string,int>::iterator it=strings.begin(); it!=strings.end(); ++it)
        foutasm << stringkeys[it->second] <<":\n\t.string\t" << it->first << '\n';
    doubleVal d;
    d.db = 1;
    foutasm << ".one:\n\t.long\t" << d.db_arr[0] << "\n\t.long\t" << d.db_arr[1] << endl;
       
}

void localfloats(symboltable* curr,ofstream &foutasm)
{
    foutasm << "\t.section\t.rodata\n";
    int size = curr->symentries.size();
    for(int i=0;i<size;i++)
    {
        if(curr->symentries[i]->t.actype == t_double && curr->symentries[i]->isConst == true )
        {
            foutasm << curr->symentries[i]->name <<":\n\t.long\t" << curr->symentries[i]->init.dbVal.db_arr[0] << "\n\t.long\t" << curr->symentries[i]->init.dbVal.db_arr[1] << endl;
        }
    }
}
void prologue(symboltable* curr,ofstream &foutasm)
{
    foutasm << "\t.text\n";
    foutasm << "\t.globl\t" << curr->name << endl;
    foutasm << "\t.type\t" << curr->name << ", @function" << endl;
    foutasm << curr->name << ":\n";
    foutasm << "\tpushq %rbp\n";
    foutasm << "\tmovq %rsp, %rbp\n";
    ostringstream s1;
    s1 << curr->offset;
	foutasm << "\tsubq $"<< s1.str() <<", %rsp\n";
}

void epilogue(symboltable* curr,ofstream &foutasm)
{
    //foutasm << ".ret_" << curr->name <<":" <<endl;
    ostringstream s1;
    s1 << curr->offset;
    foutasm << "\tleave\n\tret\n";
    //foutasm << "LFE" << funcno << ":\n";
    //foutasm << "\t.size\t" << curr->name << ", -" << curr->name << "\n"; 
}

void initializematrix(symboltable* curr,ofstream &foutasm)
{
    int size = curr->symentries.size();
    for(int i=1;i<size;i++)
    {
        if(curr->symentries[i]->t.actype == t_mat)
        {
            int r = curr->symentries[i]->t.rows;
            int c = curr->symentries[i]->t.cols;
            foutasm << "\tmovl $" << r << ", " << curr->symentries[i]->offset << "(%rbp)\n";
            foutasm << "\tmovl $" << c << ", " << curr->symentries[i]->offset+4 << "(%rbp)\n";
        }
    }
}

void updatesymboltableoffset(ofstream &foutasm)
{
    symboltable* curr;
    for(int i = 0; i<(int)globalsymboltable->symentries.size();i++)
        {
            int paramoffset = +16;
            int localoffset = 0;
            if(globalsymboltable->symentries[i]->nested_table!=NULL)
               {
                    curr = globalsymboltable->symentries[i]->nested_table;
                    for(int j = 1; j<(int)curr->symentries.size();j++)
                    {
                        if(curr->symentries[j]->isParam == true)
                        {
                            if(curr->symentries[j]->t.actype == t_char)
                            {
                                curr->symentries[j]->size = 8;
                                curr->offset += 7;   
                            }
                            if(curr->symentries[j]->t.actype == t_integer /*|| curr->symentries[j]->t.actype == t_pointer*/)
                            {
                                curr->symentries[j]->size = 8;
                                curr->offset += 4;   
                            }
                            curr->symentries[j]->offset= paramoffset;
                            paramoffset += curr->symentries[j]->size;    
                        }
                        else
                        {
                            /*if(curr->symentries[j]->t.actype == t_char)
                            {
                                curr->symentries[j]->size = 4;
                                curr->offset += 3;   
                            }*/
                            localoffset -= curr->symentries[j]->size;
                            curr->symentries[j]->offset = localoffset;
                        }
                    }
                    curr->offset -= (paramoffset-16);    
               }    //foutasm << curr->offset << endl; 

        }
}


void printassembly(vector<quadentry> quadarray, ofstream &foutasm)
{
    makeLabels(quads);
    staticdata(foutasm);

    symboltable* curr = globalsymboltable;
    int size = quadarray.size(); 
    for(int i=0;i<size;i++)
    {
    if(labels.find(i)!=labels.end())
        foutasm << labels[i] << ":\n";
    if(quadarray[i].op == "f()")
        { 
            if(quadarray[i].res != "printInt" && quadarray[i].res != "printFlt"  && quadarray[i].res != "printStr" && quadarray[i].res != "readInt" && quadarray[i].res != "readFlt")
            {
                curr = globalsymboltable->lookup(quadarray[i].res)->nested_table;
                localfloats(curr,foutasm);
                prologue(curr,foutasm);
                initializematrix(curr,foutasm);
            }
        } 
        else if(quadarray[i].op == "copy")
        {
            if((curr->lookup(quadarray[i].res))->isConst == true)
            {
                if((curr->lookup(quadarray[i].res))->t.actype == t_double)
                    {
                        foutasm << "\tmovsd " << quadarray[i].res << ", " << "%xmm0\n";
                        foutasm << "\tmovsd " << "%xmm0," << (curr->lookup(quadarray[i].res))->offset << "(%rbp)\n";
                        
                    }
                else if((curr->lookup(quadarray[i].res))->t.actype == t_integer)
                    foutasm << "\tmovl $" << quadarray[i].arg1 << ", " << (curr->lookup(quadarray[i].res))->offset << "(%rbp)\n";
                else 
                    foutasm << "\tmovb $" << (int)quadarray[i].arg1[0] << ", " << (curr->lookup(quadarray[i].res))->offset << "(%rbp)\n";
            }
            else
            {   
                if(curr->lookup(quadarray[i].res)->t.actype != t_mat)
                    {
                        if((curr->lookup(quadarray[i].res))->t.actype == t_char)
                        {
                            foutasm << "\tmovzbq " << (curr->lookup(quadarray[i].arg1))->offset << "(%rbp) ," <<  "%rax\n";
                            foutasm << "\tmovb " << "%al," << (curr->lookup(quadarray[i].res))->offset << "(%rbp)\n";    
                        }
                        else if((curr->lookup(quadarray[i].res))->t.actype == t_double)
                        {
                            foutasm << "\tmovsd " << (curr->lookup(quadarray[i].arg1))->offset << "(%rbp) ," <<  "%xmm0\n";
                            foutasm << "\tmovsd " << "%xmm0," << (curr->lookup(quadarray[i].res))->offset << "(%rbp)\n";
                        }
                        else if((curr->lookup(quadarray[i].res))->t.actype == t_integer)
                        {
                            foutasm << "\tmovl " << (curr->lookup(quadarray[i].arg1))->offset << "(%rbp) ," << "%eax\n";
                            foutasm << "\tmovl " << "%eax," << (curr->lookup(quadarray[i].res))->offset << "(%rbp)\n";
                        }
                        else if((curr->lookup(quadarray[i].res))->t.actype == t_pointer)
                        {
                            foutasm << "\tmovq " << (curr->lookup(quadarray[i].arg1))->offset << "(%rbp) ," << "%rax\n";
                            foutasm << "\tmovq " << "%rax," << (curr->lookup(quadarray[i].res))->offset << "(%rbp)\n";
                        }
                    }
                else
                    {
                        symentry* res_mat = curr->lookup(quadarray[i].res);
                        symentry* arg_mat = curr->lookup(quadarray[i].arg1);
                        int size = res_mat->t.rows * res_mat->t.cols;     
                        int t =0;
                        for(int k=0;k<size;k++)
                        {
                            foutasm << "\tmovsd " << (curr->lookup(quadarray[i].arg1))->offset+8+t << "(%rbp) ," <<  "%xmm0\n";
                            foutasm << "\tmovsd " << "%xmm0," << (curr->lookup(quadarray[i].res))->offset+8+t << "(%rbp)\n";
                            t+=8;
                        }

                    }
            }
        }
       else if(quadarray[i].op == "ret")
        {
             if(quadarray[i].res=="")
                    epilogue(curr,foutasm);
             else
             {
                if(curr->symentries[0]->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," << "%xmm0\n";
                }
                else if(curr->symentries[0]->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," << "%rax\n";
                }
                else if(curr->symentries[0]->t.actype == t_mat )
                {
                   foutasm << "\tleaq " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," << "%rax\n";
                }
                else if(curr->symentries[0]->t.actype == t_integer)
                {
                    foutasm << "\tmovl " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," << "%eax\n";   
                }
                else if(curr->symentries[0]->t.actype == t_pointer)
                {
                    foutasm << "\tmovq " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," << "%rax\n"; 
                }
                epilogue(curr,foutasm);
             }
        }

        else if(quadarray[i].op == "*")
            {
                if(curr->isPresent(quadarray[i].arg2))
                {   symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    symentry* arg2 = curr->lookup(quadarray[i].arg2);
                    if(res->t.actype == t_double)
                    {
                        foutasm << "\txorpd " << "%xmm0" <<  ", %xmm0\n";
                        foutasm << "\txorpd " << "%xmm1" <<  ", %xmm1\n";    
                        foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                        foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                        foutasm << "\tmulsd " << "%xmm1" <<  ", %xmm0\n";
                        foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";
                        foutasm << "\txorpd " << "%xmm0" <<  ", %xmm0\n";
                        foutasm << "\txorpd " << "%xmm1" <<  ", %xmm1\n";  

                    }
                    else if(res->t.actype == t_char)
                    {
                        foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rdx\n";
                        foutasm << "\timulq " << "%rdx" <<  ", %rax\n";
                        foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_mat)
                    {
                        /*ostringstream s;
                        s << labelnum;
                        string tag1 = ".LoopL" + s.str();
                        labelnum++;
                        s << labelnum;
                        string tag2 = ".LoopL" + s.str();
                        labelnum++;
                        s << labelnum;
                        string tag3 = ".LoopL" + s.str();
                        labelnum++;
                        s << labelnum;
                        string tag4 = ".LoopL" + s.str();
                        labelnum++;
                        s << labelnum;
                        string tag4 = ".LoopL" + s.str();
                        labelnum++;
                        s << labelnum;
                        string tag4 = ".LoopL" + s.str();
                        labelnum++;
                        symentry* res = curr->lookup(quadarray[i].res);
                        symentry* arg1 = curr->lookup(quadarray[i].arg1);
                        symentry* arg2 = curr->lookup(quadarray[i].arg1);
                        foutasm << "\txorq " << "%r8, %r8\n";      //m
                        foutasm << "\txorq " << "%r9, %r9\n";      //n
                        foutasm << "\txorq " << "%r10, %r10\n";    //p
                        foutasm << "\txorq " << "%r11, %r11\n";    //i
                        foutasm << "\txorq " << "%r12, %r12\n";    //j
                        foutasm << "\txorq " << "%r13, %r13\n";    //k
                        foutasm << "\txorq " << "%r14, %r14\n";    //address i
                        foutasm << "\txorq " << "%r15, %r15\n";    //address j
                        foutasm << "\tmovl " << arg1->offset << "(%rbp), %r8d\n";
                        foutasm << "\tmovl " << arg1->offset+4 << "(%rbp), %r10d\n";
                        foutasm << "\tmovl " << arg2->offset+4 << "(%rbp), %r9d\n";
                        foutasm << "\tmovl " << "$0, " << "%r11d\n";
                        foutasm << "\tmovl " << "$0, " << "%r12d\n";
                        foutasm << "\tmovl " << "$0, " << "%r13d\n";
                        foutasm << "\tjmp " << tag1 << endl;
                        foutasm << tag1 << ":"<< endl;
                        foutasm << "\tcmpl " << "%r8d" <<  ", " << "%r11d\n";
                        foutasm << "\tjge " <<  tag6 << "\n";
                        foutasm << "\tmovl " << "$0, " << "%r12d\n";
                        foutasm << "\tjmp " << tag2 << "\n";
                        foutasm << tag2 << ":"<< endl;
                        foutasm << "\tcmpl " << "%r9d" <<  ", " << "%r12d\n";
                        foutasm << "\tjge " <<  tag5 << "\n";
                        foutasm << "\tmovl " << "$0, " << "%r13d\n";
                        foutasm << "\txorpd " << "%xmm2, " << "%xmm2\n";
                        foutasm << "\tjmp " << tag3 << "\n";
                        foutasm << tag3 << ":"<< endl;
                        foutasm << "\tcmpl " << "%r10d" <<  ", " << "%r13d\n";
                        foutasm << "\tjge " <<  tag4 << "\n";

                        foutasm << "\tmovl " << "%r11d, " << "%r14d\n";
                        foutasm << "\timull " << "%r8d, " << "%r14d\n";
                        foutasm << "\taddl " << "%r13d, " << "%r14d\n";
                        foutasm << "\timull " << "$8, " << "%r14d\n";
                        
                        foutasm << "\tmovl " << "%r13d, " << "%r15d\n";
                        foutasm << "\timull " << "%r10d, " << "%r15d\n";
                        foutasm << "\taddl " << "%r12d, " << "%r15d\n";
                        foutasm << "\timull " << "$8, " << "%r15d\n";

                        foutasm << "\tmovq " << arg1->offset+8 <<"(%rbp,%r14,1), " << "%xmm0\n";
                        foutasm << "\tmovq " << arg2->offset+8 <<"(%rbp,%r15,1), " << "%xmm1\n";
                        foutasm << "\tmulsd " << "%xmm1" <<  ", %xmm0\n";                                                       
                        foutasm << "\taddsd " << "%xmm0, "<<  " %xmm2\n";
                        foutasm << "\taddl " << "$1, " << "%r13d\n";           
                        foutasm << "\tjmp " <<  tag2 << "\n";

                        foutasm << tag4 << ":"<< endl;
                        foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";
                        foutasm << "\taddl " << "$1, " << "%r10d\n";
                        foutasm << "\tjmp " <<  tag1 << "\n";

                        foutasm << tag4 << ":"<< endl;*/

                    }
                    else
                    {
                        foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                        foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%edx\n";
                        foutasm << "\timull " << "%edx" <<  ", %eax\n";
                        foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                    }
                }
                else  //only for t*8
                { 
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tmovl " << "$8 ," << "%edx\n";
                    foutasm << "\timull " << "%edx" <<  ", %eax\n";
                    foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                }
            }
        
        else if(quadarray[i].op == "+")
            {
                if(curr->isPresent(quadarray[i].arg2))
                {
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    symentry* arg2 = curr->lookup(quadarray[i].arg2);
                    if(res->t.actype == t_pointer && arg2->t.actype == t_integer)
                    {
                        foutasm << "\tmovq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        foutasm << "\txorq " << "%rdx" <<  ", %rdx\n";
                        foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%edx\n";
                        foutasm << "\taddq " << "%rdx" <<  ", %rax\n";
                        foutasm << "\tmovq " << "%rax," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_double)
                    {
                        foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                        foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                        foutasm << "\taddsd " << "%xmm1" <<  ", %xmm0\n";
                        foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_char)
                    {
                        foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rdx\n";
                        foutasm << "\taddq " << "%rdx" <<  ", %rax\n";
                        foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_mat)
                    {
                    
                        int size = res->t.rows * res->t.cols;     
                        int t =0;
                        for(int k=0;k<size;k++)
                        {
                            foutasm << "\tmovsd " << (curr->lookup(quadarray[i].arg1))->offset+8+t << "(%rbp) ," <<  "%xmm0\n";
                            foutasm << "\tmovsd " << (curr->lookup(quadarray[i].arg2))->offset+8+t << "(%rbp) ," <<  "%xmm1\n";
                            foutasm << "\taddsd " << "%xmm1," <<  "%xmm0\n";
                            foutasm << "\tmovsd " << "%xmm0," << (curr->lookup(quadarray[i].res))->offset+8+t << "(%rbp)\n";
                            t+=8;
                        }
                    }
                    else if(res->t.actype == t_integer)
                    {
                        foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                        foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%edx\n";
                        foutasm << "\taddl " << "%edx" <<  ", %eax\n";
                        foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_pointer)
                    {
                        foutasm << "\tmovq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        foutasm << "\tmovq " << arg2->offset << "(%rbp) ," << "%rdx\n";
                        foutasm << "\taddq " << "%rdx" <<  ", %rax\n";
                        foutasm << "\tmovq " << "%rax," << res->offset << "(%rbp)\n";

                    }
                }
                else
                {
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    if(res->t.actype == t_double)
                    {
                        foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                        foutasm << "\tmovsd " << ".one ," << "%xmm1\n";
                        foutasm << "\taddsd " << "%xmm1" <<  ", %xmm0\n";
                        foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_char)
                    {
                        foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        foutasm << "\taddq " << "$1" <<  ", %rax\n";
                        foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_integer)
                    {
                        foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                        foutasm << "\tmovl " << "$"<< quadarray[i].arg2<<", " << "%edx\n";
                        foutasm << "\taddl " << "%edx" <<  ", %eax\n";
                        foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_pointer)             //Assume not supported 
                    {
                        foutasm << "\tmovq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        int size = (res->t.pointerto)->size;
                        foutasm << "\tmovq $" << size << " ," << "%rdx\n";
                        foutasm << "\taddq " << "%rdx" <<  ", %rax\n";
                        foutasm << "\tmovq " << "%rax," << res->offset << "(%rbp)\n";

                    }

                }
            }
        
        else if(quadarray[i].op == "=[]")
           {
             //foutasm << quadarray[i].res << " = " << quadarray[i].arg1 << "[" << quadarray[i].arg2 << "]";
             if(curr->isPresent(quadarray[i].arg2))
             {   symentry* res = curr->lookup(quadarray[i].res);
                 symentry* arg1 = curr->lookup(quadarray[i].arg1);
                 symentry* arg2 = curr->lookup(quadarray[i].arg2); 
                 foutasm << "\txorq " << "%rax ," << "%rax\n";
                 foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                 foutasm << "\tmovsd " << arg1->offset << "(%rbp,%rax,1) ," << "%xmm0\n";;
                 foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";
             }
             else
             {
                symentry* res = curr->lookup(quadarray[i].res);
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                stringstream ss(quadarray[i].arg2);
                int k;
                ss >> k;
                foutasm << "\txorq " << "%rax ," << "%rax\n";
                foutasm << "\tmovl " << "$" << k << ", " << "%eax\n";
                foutasm << "\tmovl " << arg1->offset << "(%rbp,%rax,1) ," << "%edx\n";;
                foutasm << "\tmovl " << "%edx," << res->offset << "(%rbp)\n";

             }
         } 
        
        else if(quadarray[i].op == "[]=")
            {
                if(curr->isPresent(quadarray[i].arg2))
                {   symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    symentry* arg2 = curr->lookup(quadarray[i].arg2);
                    foutasm << "\txorq " << "%rax ," << "%rax\n";
                    foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";;
                    foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp,%rax,1)\n";
                }
                else 
                {   
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    stringstream ss(quadarray[i].arg2);
                    int k;
                    ss >> k;
                    k = k*8+8;
                    foutasm << "\txorq " << "%rax ," << "%rax\n";
                    foutasm << "\tmovl $" << k << ", " << "%eax\n";
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";;
                    foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp,%rax,1)\n";
                
                }
            }
        else if(quadarray[i].op == "-")
        {
                if(quadarray[i].arg2!="1")
                {
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    symentry* arg2 = curr->lookup(quadarray[i].arg2);
                    if(res->t.actype == t_double)
                    {
                        foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                        foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                        foutasm << "\tsubsd " << "%xmm1" <<  ", %xmm0\n";
                        foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_char)
                    {
                        foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rdx\n";
                        foutasm << "\tsubq " << "%rdx" <<  ", %rax\n";
                        foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_mat)
                    {
                        int size = res->t.rows * res->t.cols;     
                        int t =0;
                        for(int k=0;k<size;k++)
                        {
                            foutasm << "\tmovsd " << (curr->lookup(quadarray[i].arg1))->offset+8+t << "(%rbp) ," <<  "%xmm0\n";
                            foutasm << "\tmovsd " << (curr->lookup(quadarray[i].arg2))->offset+8+t << "(%rbp) ," <<  "%xmm1\n";
                            foutasm << "\tsubsd " << "%xmm1," <<  "%xmm0\n";
                            foutasm << "\tmovsd " << "%xmm0," << (curr->lookup(quadarray[i].res))->offset+8+t << "(%rbp)\n";
                            t+=8;
                        }
                    }
                    else
                    {
                        foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                        foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%edx\n";
                        foutasm << "\tsubl " << "%edx" <<  ", %eax\n";
                        foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                    }
            }
             else
                {
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    if(res->t.actype == t_double)
                    {
                        foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                        foutasm << "\tmovsd " << ".one ," << "%xmm1\n";
                        foutasm << "\tsubsd " << "%xmm1" <<  ", %xmm0\n";
                        foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_char)
                    {
                        foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        foutasm << "\tsubq " << "$1" <<  ", %rax\n";
                        foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_integer)
                    {
                        foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                        foutasm << "\tmovl " << "$1, " << "%edx\n";
                        foutasm << "\tsubl " << "%edx" <<  ", %eax\n";
                        foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_pointer)             //Assume not supported 
                    {
                        foutasm << "\tmovq " << arg1->offset << "(%rbp) ," << "%rax\n";
                        int size = (res->t.pointerto)->size;
                        foutasm << "\tmovq $" << size << " ," << "%rdx\n";
                        foutasm << "\tsubq " << "%rdx" <<  ", %rax\n";
                        foutasm << "\tmovq " << "%rax," << res->offset << "(%rbp)\n";

                    }

                }
            
        }
        else if(quadarray[i].op == "-u")
            {
                symentry* res = curr->lookup(quadarray[i].res);
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                if(res->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                    foutasm << "\tmovsd " <<  "$0 ," << "%xmm1\n";
                    foutasm << "\tsubsd " << "%xmm1" <<  ", %xmm0\n";
                    foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";

                }
                else if(res->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tmovzbq " << "$0 ," << "%rdx\n";
                    foutasm << "\tsubq " << "%rdx" <<  ", %rax\n";
                    foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";

                }
                else if(res->t.actype == t_mat)
                {
                    int size = res->t.rows * res->t.cols;     
                    int t =0;
                    for(int k=0;k<size;k++)
                    {
                        foutasm << "\tmovsd " << (curr->lookup(quadarray[i].arg1))->offset+8+t << "(%rbp) ," <<  "%xmm0\n";
                        foutasm << "\txorpd " << "%xmm1, " <<  "%xmm1\n";
                        foutasm << "\tsubsd " << "%xmm0, " <<  "%xmm1\n";
                        foutasm << "\tmovsd " << "%xmm1, " << (curr->lookup(quadarray[i].res))->offset+8+t << "(%rbp)\n";
                        t+=8;
                    }
                }
                else
                {
                    foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tmovl " << "$0 ," << "%edx\n";
                    foutasm << "\tsubl " << "%edx" <<  ", %eax\n";
                    foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                }
            }
        else if(quadarray[i].op == ".'")
           {
                ostringstream s;
                s << labelnum;
                string tag1 = ".LoopL" + s.str();
                labelnum++;
                s << labelnum;
                string tag2 = ".LoopL" + s.str();
                labelnum++;
                s << labelnum;
                string tag3 = ".LoopL" + s.str();
                labelnum++;
                s << labelnum;
                string tag4 = ".LoopL" + s.str();
                labelnum++;
                symentry* res = curr->lookup(quadarray[i].res);
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                foutasm << "\txorq " << "%r8, %r8\n";      //m
                foutasm << "\txorq " << "%r9, %r9\n";      //n
                foutasm << "\txorq " << "%r10, %r10\n";    //i
                foutasm << "\txorq " << "%r11, %r11\n";    //j
                foutasm << "\txorq " << "%r12, %r12\n";    //address i
                foutasm << "\txorq " << "%r13, %r13\n";    //address j
                foutasm << "\tmovl " << arg1->offset << "(%rbp), %r8d\n";
                foutasm << "\tmovl " << arg1->offset+4 << "(%rbp), %r9d\n";
                foutasm << "\tmovl " << "$0, " << "%r10d\n";
                foutasm << "\tmovl " << "$0, " << "%r11d\n";
                foutasm << "\tjmp " << tag1 << endl;
                foutasm << tag1 << ":"<< endl;
                foutasm << "\tcmpl " << "%r8d" <<  ", " << "%r10d\n";
                foutasm << "\tjge " <<  tag4 << "\n";
                foutasm << "\tmovl " << "$0, " << "%r11d\n";
                foutasm << "\tjmp " << tag2 << "\n";
                foutasm << tag2 << ":"<< endl;
                foutasm << "\tcmpl " << "%r9d" <<  ", " << "%r11d\n";
                foutasm << "\tjge " <<  tag3 << "\n";
                foutasm << "\tmovl " << "%r11d, " << "%r12d\n";
                foutasm << "\timull " << "%r8d, " << "%r12d\n";
                foutasm << "\taddl " << "%r10d, " << "%r12d\n";
                foutasm << "\timull " << "$8, " << "%r12d\n";
                
                foutasm << "\tmovl " << "%r10d, " << "%r13d\n";
                foutasm << "\timull " << "%r9d, " << "%r13d\n";
                foutasm << "\taddl " << "%r11d, " << "%r13d\n";
                foutasm << "\timull " << "$8, " << "%r13d\n";

                foutasm << "\tmovq " << arg1->offset+8 <<"(%rbp,%r13,1), " << "%xmm0\n";                                
                foutasm << "\tmovq " << "%xmm0, "<< res->offset+8 <<"(%rbp,%r12,1)" << "\n";
                foutasm << "\taddl " << "$1, " << "%r11d\n";           
                foutasm << "\tjmp " <<  tag2 << "\n";

                foutasm << tag3 << ":"<< endl;

                foutasm << "\taddl " << "$1, " << "%r10d\n";
                foutasm << "\tjmp " <<  tag1 << "\n";

                foutasm << tag4 << ":"<< endl;
            }
        else if(quadarray[i].op == "/")
            {
                symentry* res = curr->lookup(quadarray[i].res);
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                symentry* arg2 = curr->lookup(quadarray[i].arg2);
                if(res->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                    foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                    foutasm << "\tdivsd " << "%xmm1" <<  ", %xmm0\n";
                    foutasm << "\tmovsd " << "%xmm0," << res->offset << "(%rbp)\n";

                }
                else if(res->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rcx\n";
                    foutasm << "\tcltq\n";
                    foutasm << "\tidivq " << "%rcx\n";
                    foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";

                }
                else
                {
                    foutasm << "\txorq " << "%rax ," << "%rax\n";
                    foutasm << "\txorq " << "%rcx ," << "%rcx\n";
                    foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%ecx\n";
                    foutasm << "\tcltd\n";
                    foutasm << "\tidivl " << "%ecx\n";
                    foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";

                }
            }
        else if(quadarray[i].op == "%")
            {
                symentry* res = curr->lookup(quadarray[i].res);
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                symentry* arg2 = curr->lookup(quadarray[i].arg2);
                if(res->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << arg1->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rcx\n";
                    foutasm << "\tcltq\n";
                    foutasm << "\tidivq " << "%rcx\n";
                    foutasm << "\tmovb " << "%dl," << res->offset << "(%rbp)\n";

                }
                else
                {
                    foutasm << "\txorq " << "%rax ," << "%rax\n";
                    foutasm << "\txorq " << "%rcx ," << "%rcx\n";
                    foutasm << "\tmovl " << arg1->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%ecx\n";
                    foutasm << "\tcltd\n";
                    foutasm << "\tidivl " << "%ecx\n";
                    foutasm << "\tmovl " << "%edx," << res->offset << "(%rbp)\n";
                }
            }
         else if(quadarray[i].op == "param")
                {
                    //foutasm << "param " << quadarray[i].res;
                    ostringstream ss;
                    if(curr->isPresent(quadarray[i].res))
                     {
                        if(curr->lookup(quadarray[i].res)->t.actype != t_mat)
                        {
                        paramno++;
                        if((curr->lookup(quadarray[i].res))->t.actype == t_char)
                        {
                            ss << "\tmovzbq " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," <<  "%rax\n";
                            ss << "\tpushq " << "%rax\n"; 
   
                        }
                        else if((curr->lookup(quadarray[i].res))->t.actype == t_double)
                        {

                            ss << "\txorpd %xmm0," <<  "%xmm0\n";
                            ss << "\tmovsd " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," <<  "%xmm0\n";
                            ss << "\tsubq $"<< 8 <<", %rsp\n";
                            ss << "\tmovsd " << "%xmm0, (%rsp) \n";
                        }
                        else if((curr->lookup(quadarray[i].res))->t.actype == t_integer)
                        {
                            ss << "\tmovl " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," << "%eax\n";
                            ss << "\tpushq " << "%rax\n";
                        }
                        else if((curr->lookup(quadarray[i].res))->t.actype == t_pointer)
                        {
                            ss << "\tmovq " << (curr->lookup(quadarray[i].res))->offset << "(%rbp) ," << "%rax\n";
                            ss << "\tpushq " << "%rax\n";
                        }

                        }
                    else
                        {

                            symentry* res_mat = curr->lookup(quadarray[i].res);
                            int size = res_mat->t.rows * res_mat->t.cols;     
                            int t=size*8;
                            for(int k=0;k<size;k++)
                            {
                                paramno++;
                                ss << "\tmovsd " << res_mat->offset+t << "(%rbp) ," <<  "%xmm0\n";
                                ss << "\tsubq $"<< 8 <<", %rsp\n";
                                ss << "\tmovsd " << "%xmm0, (%rsp) \n";
                                t-=8;
                            }
                            ss << "\tsubq " << "$8, %rsp\n";

                        }
                    }
                    else if(quadarray[i].res[0] == '.')
                    {
                        paramno++;
                        ss << "\tmovq $" << quadarray[i].res <<  " ," << "%rax\n";
                        ss << "\tpushq " << "%rax\n";
                    }
                    params.push_back(ss.str());
                    paramindex++;

                }

         else if(quadarray[i].op == "=call")
            {
                //foutasm << quadarray[i].res << " = " <<"call " << quadarray[i].arg1 << "," << quadarray[i].arg2;
                int paramsize = params.size();
                for(int k=0;k<paramsize;k++)
                {
                    string l = params.back();
                    params.pop_back();
                    foutasm << l;
                    paramindex = 0;

                }
                if(quadarray[i].arg1 == "printInt")
                {
                    foutasm<< "\tmovl %eax, %edi\n";
                }
                if(quadarray[i].arg1 == "printStr")
                {
                    foutasm<< "\tmovq %rax, %rdi\n";
                }
                if(quadarray[i].arg1 == "readInt" || quadarray[i].arg1 == "readFlt")
                {
                    foutasm<< "\tmovq %rax, %rdi\n";
                }
                symentry* res = curr->lookup(quadarray[i].res);
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                //int n;
                //stringstream ss(quadarray[i].arg2);
                //ss >> n;
                int n = paramno;
                paramno = 0;
                foutasm << "\tcall " <<  quadarray[i].arg1 << endl;
                for(int k = 0;k<n;k++)
                {
                    foutasm<< "\tpopq %rbx\n";
                }
                foutasm<< "\txorq %rbx, %rbx\n";
                if (res->t.actype == t_void)
                {
                    //Do nothing
                }
                else if(res->t.actype != t_mat)
                    {
                        if(res->t.actype == t_char)
                        {
                            foutasm << "\tmovb " << "%al," << res->offset << "(%rbp)\n";    
                        }
                        else if(res->t.actype == t_double)
                        {
                            foutasm << "\tmovsd " << "%xmm0, " << res->offset << "(%rbp)\n";
                        }
                        else if(res->t.actype == t_integer)
                        {
                            foutasm << "\tmovl " << "%eax," << res->offset << "(%rbp)\n";
                        }
                        else if(res->t.actype == t_pointer)
                        {
                            foutasm << "\tmovq " << "%rax," << res->offset << "(%rbp)\n";   
                        }
                    }
                else
                    {
                        int size = res->t.rows * res->t.cols;     
                        int t =0;
                        for(int k=0;k<size;k++)
                        {
                            foutasm << "\tmovsd " << 8+t << "(%rax)," <<  "%xmm0\n";
                            foutasm << "\tmovsd " << "%xmm0, " << res->offset+8+t << "(%rbp)\n";
                            t+=8;
                        }

                    }
                foutasm<< "\txorpd %xmm0, %xmm0\n";
                foutasm<< "\txorq %rax, %rax\n";



            }
        
        else if(quadarray[i].op == "if<")
        {
            stringstream ss(quadarray[i].res);
            int x; 
            ss >> x;
            string label = labels[x];
            symentry* arg1 = curr->lookup(quadarray[i].arg1);
            symentry* arg2 = curr->lookup(quadarray[i].arg2);
            if(arg1->t.actype == t_double)
            {
                foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                foutasm << "\tucomisd " << "%xmm1" <<  ", %xmm0\n";
                foutasm << "\tjl " <<  label << "\n";

            }
            else if(arg1->t.actype == t_char)
            {
                foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rax\n";
                foutasm << "\tcmpb " << "%al" <<  ", " <<  arg1->offset << "(%rbp)\n";
                foutasm << "\tjl " <<  label << "\n";
            }
            else if(arg1->t.actype == t_integer)
            {
                foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                foutasm << "\tcmpl " << "%eax" <<  ", " <<  arg1->offset << "(%rbp)\n";
                foutasm << "\tjl " <<  label << "\n";
            }
        }
        
        else if(quadarray[i].op == "if>")
        {
            stringstream ss(quadarray[i].res);
            int x; 
            ss >> x;
            string label = labels[x];
            symentry* arg1 = curr->lookup(quadarray[i].arg1);
            symentry* arg2 = curr->lookup(quadarray[i].arg2);
            if(arg1->t.actype == t_double)
            {
                foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                foutasm << "\tucomisd " << "%xmm1" <<  ", %xmm0\n";
                foutasm << "\tjg " <<  label << "\n";

            }
            else if(arg1->t.actype == t_char)
            {
                foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rax\n";
                foutasm << "\tcmpb " << "%al" <<  ", " <<  arg1->offset << "(%rbp)\n";
                foutasm << "\tjg " <<  label << "\n";
            }
            else if(arg1->t.actype == t_integer)
            {
                foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                foutasm << "\tcmpl " << "%eax" <<  ", " <<  arg1->offset << "(%rbp)\n";
                foutasm << "\tjg " <<  label << "\n";
            }

        }
        else if(quadarray[i].op == "if<=")
            {
                stringstream ss(quadarray[i].res);
                int x; 
                ss >> x;
                string label = labels[x];
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                symentry* arg2 = curr->lookup(quadarray[i].arg2);
                if(arg1->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                    foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                    foutasm << "\tucomisd " << "%xmm1" <<  ", %xmm0\n";
                    foutasm << "\tjle " <<  label << "\n";

                }
                else if(arg1->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tcmpb " << "%al" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjle " <<  label << "\n";
                }
                else if(arg1->t.actype == t_integer)
                {
                    foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tcmpl " << "%eax" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjle " <<  label << "\n";
                }
            }
        else if(quadarray[i].op == "if>=")
            {
                stringstream ss(quadarray[i].res);
                int x; 
                ss >> x;
                string label = labels[x];
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                symentry* arg2 = curr->lookup(quadarray[i].arg2);
                if(arg1->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                    foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                    foutasm << "\tucomisd " << "%xmm1" <<  ", %xmm0\n";
                    foutasm << "\tjge " <<  label << "\n";

                }
                else if(arg1->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tcmpb " << "%al" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjge " <<  label << "\n";
                }
                else if(arg1->t.actype == t_integer)
                {
                    foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tcmpl " << "%eax" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjge " <<  label << "\n";
                }
            }
        else if(quadarray[i].op == "if==")
            {
                stringstream ss(quadarray[i].res);
                int x; 
                ss >> x;
                string label = labels[x];
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                symentry* arg2 = curr->lookup(quadarray[i].arg2);
                if(arg1->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                    foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                    foutasm << "\tucomisd " << "%xmm1" <<  ", %xmm0\n";
                    foutasm << "\tje " <<  label << "\n";

                }
                else if(arg1->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tcmpb " << "%al" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tje " <<  label << "\n";
                }
                else if(arg1->t.actype == t_integer)
                {
                    foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tcmpl " << "%eax" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tje " <<  label << "\n";
                }
            }
        else if(quadarray[i].op == "if!=")
            {
                stringstream ss(quadarray[i].res);
                int x; 
                ss >> x;
                string label = labels[x];
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                symentry* arg2 = curr->lookup(quadarray[i].arg2);
                if(arg1->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                    foutasm << "\tmovsd " << arg2->offset << "(%rbp) ," << "%xmm1\n";
                    foutasm << "\tucomisd " << "%xmm1" <<  ", %xmm0\n";
                    foutasm << "\tjne " <<  label << "\n";

                }
                else if(arg1->t.actype == t_char)
                {
                    foutasm << "\tmovzbq " << arg2->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tcmpb " << "%al" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjne " <<  label << "\n";
                }
                else if(arg1->t.actype == t_integer)
                {
                    foutasm << "\tmovl " << arg2->offset << "(%rbp) ," << "%eax\n";
                    foutasm << "\tcmpl " << "%eax" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjne " <<  label << "\n";
                }
            }
        else if(quadarray[i].op == "if")
            {
                stringstream ss(quadarray[i].res);
                int x; 
                ss >> x;
                string label = labels[x];
                symentry* arg1 = curr->lookup(quadarray[i].arg1);
                if(arg1->t.actype == t_double)
                {
                    foutasm << "\tmovsd " << arg1->offset << "(%rbp) ," << "%xmm0\n";
                    foutasm << "\txorpd " << "%xmm1, " << "%xmm1\n";
                    foutasm << "\tucomisd " << "%xmm1" <<  ", %xmm0\n";
                    foutasm << "\tjne " <<  label << "\n";

                }
                else if(arg1->t.actype == t_char)
                {
                    foutasm << "\txorq %rax, %rax\n";
                    foutasm << "\tcmpb " << "%al" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjne " <<  label << "\n";
                }
                else if(arg1->t.actype == t_integer)
                {
                    foutasm << "\txorl %eax, %eax\n";
                    foutasm << "\tcmpl " << "%eax" <<  ", " <<  arg1->offset << "(%rbp)\n";
                    foutasm << "\tjne " <<  label << "\n";
                }
            }
        else if(quadarray[i].op == "goto")
            {
                stringstream ss(quadarray[i].res);
                int x; 
                ss >> x;
                string label = labels[x];
                foutasm << "\tjmp " <<  label << "\n";
            }
        else if(quadarray[i].op == "&")
                {
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    foutasm << "\tleaq " << arg1->offset << "(%rbp) ," << "%rax\n";
                    foutasm << "\tmovq " << "%rax," << res->offset << "(%rbp)\n";

                }

        else if(quadarray[i].op == "*val")
                {
                   //foutasm << quadarray[i].res << " = *(" << quadarray[i].arg1 << ")";
                    symentry* res = curr->lookup(quadarray[i].res);
                    symentry* arg1 = curr->lookup(quadarray[i].arg1);
                    foutasm << "\tmovq " << arg1->offset << "(%rbp), " << "%rax\n";
                    if(res->t.actype == t_char)
                    {
                        foutasm << "\tmovzbq (%rax) ," << "%rdx\n";
                        foutasm << "\tmovb " << "%dl," << res->offset << "(%rbp)\n";

                    }
                    else if(res->t.actype == t_integer)
                    {
                        foutasm << "\tmovl (%rax) ," << "%edx\n";
                        foutasm << "\tmovl " << "%edx," << res->offset << "(%rbp)\n";
                    }
                }
       
    }

}

int main(int argc, char* argv[])
{
    if ( argc != 2 ) 
    {
        cout << "Error: The program excepts one arguement for the input filename in the format filename.c";
    }
    else{
    ofstream foutasm;
    ofstream foutquads;
    string s = argv[1];
    int l = s.length();
    s = s.substr(0,l-1-1);
    l = s.length();
    string s1 = s + ".asm";
    foutasm.open(s1.c_str());
    string s2 = s.substr(0,l-1-4)+"quads"+s[l-1]+".out";
    foutquads.open(s2.c_str());
    freopen(argv[1],"r",stdin);
    int a = yyparse();
	if(a==0)
	{
        updatesymboltableoffset(foutasm);
		 // globalsymboltable->print();
		 // for(int i = 0; i<(int)globalsymboltable->symentries.size();i++)
		 // {
		 // 	if(globalsymboltable->symentries[i]->nested_table!=NULL)
		 // 		globalsymboltable->symentries[i]->nested_table->print();
		 // }
		printassembly(quads->quadarray,foutasm);
        quads->print(foutquads);
	}
 //    }
}
	return 1;	
}
