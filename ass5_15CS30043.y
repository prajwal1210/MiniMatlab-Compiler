%{
	#include<stdio.h>
	#include "ass5_15CS30043_translator.h"
	#include "ass5_15CS30043_target_translator.cxx"
	#include <string>
	#include <sstream>
	#include <cstring>
	int yyerror(string);
	extern int yylex(void);
	//exp_attr exp;	
	dec_attr curr;				//global variable to replicate inherited attribute functioning. We need to pass on the type information from type speciifer to the
	bool dynallocerror;			//to check if a matrix has been dynamically allocated and is not a function return type
	string func_name;			//global variable to store the function name to generate the quad at appropriate place in the quadarray

%}

%union{
	id_attr id;
	int intVal;
	char charVal;
	double dbVal;
	char* stringVal;
	struct exp_attr exp;
	dec_attr dec;
	int instr;
	vector<int>* nextList;
	vector<exp_attr>* arglist;
	init inr;

}

%token<id> IDENTIFIER
%token<intVal> INT_CONSTANT
%token<dbVal> FLOAT_CONSTANT
%token<charVal> CHAR_CONSTANT
%token<intVal> ZERO_CONSTANT
%token<stringVal> STRING_LITERAL

%token UNSIGNED
%token BREAK
%token VOID
%token RETURN
%token CASE
%token FLOAT
%token SHORT
%token CHAR
%token FOR
%token SIGNED
%token WHILE
%token GOTO
%token BOOL
%token CONTINUE
%token IF
%token DEFAULT
%token DO
%token INT
%token SWITCH
%token DOUBLE
%token LONG
%token ELSE
%token MATRIX
%token DASHARROW /* -> */
%token PLUSPLUS	/* ++ */
%token MINMIN /* -- */
%token DOTQUOTE /* .' */
%token LSHIFT /* << */
%token RSHIFT /* >> */
%token LTE /* <= */
%token GTE /* >= */
%token EQUALS /* == */
%token NEQUALS /* != */
%token LAND /* && */
%token LOR  /* || */
%token STAREQ /* *= */
%token DIVEQ /* /= */
%token MODEQ /* %= */
%token PLUSEQ /* += */
%token MINEQ /* -= */
%token LSHIFTEQ /* <<= */
%token RSHIFTEQ /* >>= */
%token ANDEQ /* &= */
%token POWEQ /* ^= */
%token OREQ /* |= */
%token ERR

%type <exp> expression_opt parameter_type_list parameter_list parameter_declaration primary_expression postfix_expression unary_expression cast_expression multiplicative_expression additive_expression shift_expression relational_expression  equality_expression AND_expression exclusive_OR_expression inclusive_OR_expression logical_AND_expression logical_OR_expression conditional_expression assignment_expression expression constant_expression  direct_declarator init_declarator init_declarator_list init_declarator_list_opt declarator
%type <charVal> unary_operator assignment_operator 
%type <instr> M
%type <nextList> N
%type <dec> type_specifier
%type <dec> K
%type <nextList> statement compound_statement selection_statement iteration_statement jump_statement block_item_list_opt block_item_list block_item 
%type <arglist> argument_expression_list argument_expression_list_opt initializer_row initializer_row_list
%type <inr> initializer
//%type <dec>

%start translation_unit


%%

/*Expressions*/

primary_expression: IDENTIFIER 			{	
											//We see if the identifier is present in the currentsymboltable
											if(currentsymboltable->isPresent($1.name))
												{
													$$.addr = currentsymboltable->lookup($1.name);
													$$.t_exp = &($$.addr->t);
					   								$$.falselist = NULL;
					   								$$.isConst = false;
					   								$$.num_stars = 0; 
													$$.isString = false;
													$$.strkey = -1;
												
					   							}
											else
												if(globalsymboltable->isPresent($1.name)) //We look in the globalsymboltable
													{
														$$.addr = globalsymboltable->lookup($1.name);
														$$.t_exp = &($$.addr->t);
														$$.truelist = NULL;
					   									$$.falselist = NULL;
					   									$$.isConst = false;
					   									$$.num_stars = 0;
														$$.isString = false;
														$$.strkey = -1;

													}

												else //If not found in both we throw error 
													{
														cout << "Identifier not declared" << endl;
														exit(-1);		//error
													}		
					
										}

				   |INT_CONSTANT		{	//We will create a new temporary and initialize it to the INT_CONSTANT.
				   							basictype t = t_integer;
				   							type* t_int = new type(t);
				   							symentry* tmp = currentsymboltable->gentemp(*t_int);
					   						$$.addr = tmp;
					   						initialVal i;
					   						i.intVal = $1;
					   						$$.addr->setInitialVal(i);
											$$.addr->isConst = true;
					   						ostringstream str1;
					   						str1 << $1;
					   						quads->emit(str1.str(),tmp->name); 	//Generate appropriate copy quad
					   						$$.t_exp = t_int;
					   						$$.truelist = NULL;
					   						$$.falselist = NULL;
					   						$$.isConst = true;
					   						$$.num_stars = 0;
											$$.isString = false;
											$$.strkey = -1;


					   					}
				   
				   |FLOAT_CONSTANT		{
				   							//We will create a new temporary and initialize it to the FLOAT_CONSTANT.
				   							basictype t = t_double;
				   							type* t_doub = new type(t);
				   							symentry* tmp = currentsymboltable->gentemp(*t_doub);
					   						$$.addr = tmp;
					   						initialVal i;
					   						i.dbVal.db = $1;
					   						$$.addr->setInitialVal(i);
											$$.addr->isConst = true;
					   						ostringstream str1;
					   						str1  << $1;
					   						quads->emit(str1.str(),tmp->name); 	//Generate appropriate copy quad
					   						$$.t_exp = t_doub;
					   						$$.truelist = NULL;
					   						$$.falselist = NULL;
					   						$$.isConst = true;
					   						$$.num_stars = 0;
											$$.isString = false;
											$$.strkey = -1;
					   					}

				   |CHAR_CONSTANT 		{
				   							//We will create a new temporary and initialize it to the CHAR_CONSTANT.
				   							basictype t = t_char;
				   							type* t_char = new type(t);
				   							symentry* tmp = currentsymboltable->gentemp(*t_char);
					   						$$.addr = tmp;
					   						initialVal i;
					   						i.charVal = $1;
					   						$$.addr->setInitialVal(i);
											$$.addr->isConst = true;
					   						ostringstream str1;
					   						str1 << $1;
					   						quads->emit(str1.str(),tmp->name);	//Generate appropriate copy quad
					   						$$.t_exp = t_char;
					   						$$.truelist = NULL;
					   						$$.falselist = NULL;
					   						$$.isConst = true;
					   						$$.num_stars = 0;
											$$.isString = false;
											$$.strkey = -1;

				   						}

				   |ZERO_CONSTANT		{	//We will create a new temporary and initialize it to 0.
				   							basictype t = t_integer;
				   							type* t_int = new type(t);
				   							symentry* tmp = currentsymboltable->gentemp(*t_int);
					   						$$.addr = tmp;
					   						initialVal i;
					   						i.intVal = $1;
					   						$$.addr->setInitialVal(i);
											$$.addr->isConst = true;
					   						ostringstream str1;
					   						str1 << $1;
					   						quads->emit(str1.str(),tmp->name); 	//Generate appropriate copy quad
					   						$$.t_exp = t_int;
					   						$$.truelist = NULL;
					   						$$.falselist = NULL;
					   						$$.isConst = true;
					   						$$.num_stars = 0;
											$$.isString = false;
											$$.strkey = -1;


				   						}
				   
				   |STRING_LITERAL		{
				   							//Not supported
											basictype t = t_char;
											type* t1 = new type(t);
											t = t_pointer;
											$$.t_exp = new type(t);
											$$.t_exp->pointerto = t1;
											$$.isString = true; 
											string s($1);
											ostringstream stream; 
											if(strings.count(s))
											{
												$$.strkey = strings[s];
											}
											else
											{
												strings[s] = stringkeys.size();
												stream << stringkeys.size();
												string s1 = ".msg" + stream.str();
												stringkeys.push_back(s1);
												$$.strkey = strings[s];
											}

				  						}

				   |'(' expression ')' 	{	$$=$2;	}
				   ;



postfix_expression: primary_expression 												{	$$=$1;
																						$$.isMattype = false;			
																					}

				   |primary_expression '[' expression ']' '[' expression ']' 		{
				   																		if($1.t_exp->actype!=t_mat)					//If the primary_expression was not a matrix its an error
				   																		{
				   																			cout << "Not a matrix type" <<endl;
				   																			exit(-1);
				   																		}
				   																		else
				   																		{	//We calculate the offset which is being accesed by generating appropriate quads
				   																			$$=$1;					
				   																			$$.isMattype = true;			//This marks that the array should be dereferenced before being used 
				   																			type* t = new type(t_integer);
				   																			symentry* temp = currentsymboltable->gentemp(*t);
				   																			//ostringstream str1;
				   																			//str1 << $1.t_exp->cols;
					   																		quads->emit("=[]",$1.addr->name,"4",temp->name); 				//Load cols
				   																			quads->emit("*",$3.addr->name,temp->name,temp->name);			//Multiply cols by the row index 
				   																			//str1 << $1.t_exp->rows;
				   																			quads->emit("+",temp->name,$6.addr->name,temp->name);			//Add the column index
																							quads->emit("*",temp->name,"8",temp->name);						//Multiply by 8(size of double)
																							quads->emit("+",temp->name,"8",temp->name);						//Offset by because first element starts at basepointer + 8
				   																			$$.addr = temp;
				   																			$$.mat = $1.addr;
				   																			$$.t_exp = new type(t_double);
				   																		}
				   																		$$.isConst = false;		//No longer a static constant

				   																	}
				   |postfix_expression '(' argument_expression_list_opt ')'			{
				   																		$$=$1;
				   																		if(!globalsymboltable->isPresent($1.addr->name))					//Check if function is present
				   																		{
				   																			cout << "No such function defined" << endl;
				   																			exit(-1);
				   																		}
				   																		symentry* func = globalsymboltable->lookup($1.addr->name);			//We lookup the function in the global symboltable
				   																		symboltable* functable = func->nested_table;
				   																		int paramn = 0;														//No. of parameter
				   																		if($3!=NULL)
				   																		{
				   																			//Match parameters and emit appropriate quads
 				   																			if(parametercheck(functable,$3))								
				   																			{
				   																				int argsize = $3->size();
				   																				for(int i=0;i<argsize;i++)
				   																				{
																									if((*$3)[i].isString == true)
																									{
																										quads->emit("param","",stringkeys[(*$3)[i].strkey]);
				   																						paramn++;	
																									}
																									else 
				   																					{	
																										quads->emit("param","",(*$3)[i].addr->name);
				   																						paramn++;
																									}
				   																				}
				   																			}
				   																			else
				   																				{
				   																					cout << "Error while fucntion call" << endl;
				   																					exit(-1);
				   																				}
				   																		}
				   																		$$.t_exp = &(functable->symentries[0]->t);  //return type of the function 
				   																		$$.addr = currentsymboltable->gentemp(*$$.t_exp);
				   																		ostringstream s1;
				   																		s1 << paramn;
				   																		quads->emit("=call",$1.addr->name,s1.str(),$$.addr->name);
				   																		$$.isConst = false;
				   																	}
				   |postfix_expression '.' IDENTIFIER 								{
				   																		//Not supported
				   																	}
				   |postfix_expression DASHARROW IDENTIFIER 						{
				   																		//Not supported
				   																	}
				   |postfix_expression PLUSPLUS								{
				   																$$=$1;
				   																$$.addr = currentsymboltable->gentemp(*$$.t_exp);
				   																//Check if the expression needs to be dereferenced first if its a Matrix. If its a pointer dereferencing then postfix++ has higher precedence that * so that need to be dereferenced
				   																if($1.isMattype==true)
				   																{
				   																	type* ty = new type(t_double);
				   																	symentry* tmp = currentsymboltable->gentemp(*ty);
				   																	quads->emit("=[]",$1.mat->name,$1.addr->name,$$.addr->name);
				   																	$$.t_exp = ty;
				   																	$$.addr->t = *ty;
				   																	$$.addr->size = ty->get_size();
				   																	quads->emit("+",$$.addr->name,"1",tmp->name);
				   																	quads->emit("[]=",tmp->name,$1.addr->name,$1.mat->name);
				   																}
				   																else{ //If does not need dereferencing generate normal quads
				   																	quads->emit($1.addr->name,$$.addr->name);
				   																	quads->emit("+",$1.addr->name,"1",$1.addr->name);
				   																}
				   																$$.isMattype = false;
				   																$$.isConst = false;


				   															}

				   |postfix_expression MINMIN								{
				   																$$=$1;
				   																$$.addr = currentsymboltable->gentemp(*$$.t_exp);
				   																//Check if the expression needs to be dereferenced first if its a Matrix. If its a pointer dereferencing then postfix-- has higher precedence that * so that need to be dereferenced
				   																if($1.isMattype==true)
				   																{
				   																	type* ty = new type(t_double);
				   																	symentry* tmp = currentsymboltable->gentemp(*ty);
				   																	quads->emit("=[]",$1.mat->name,$1.addr->name,$$.addr->name);
				   																	$$.addr->t = *ty;
				   																	$$.t_exp = ty;
				   																	$$.addr->size = ty->get_size();
				   																	cout << $$.addr->name << ":" << $$.addr->t.size;
				   																	quads->emit("-",$$.addr->name,"1",tmp->name);
				   																	quads->emit("[]=",tmp->name,$1.addr->name,$1.mat->name);
				   																}
				   																else{ //If does not need dereferencing generate normal quads
				   																	quads->emit($1.addr->name,$$.addr->name);
				   																	quads->emit("-",$1.addr->name,"1",$1.addr->name);
				   																}

				   																$$.isMattype = false;
				   																$$.isConst = false;

				   															}

				   |postfix_expression DOTQUOTE								{
				   																if($1.t_exp->actype!=t_mat)	//check if it is Matrix 
				   																{
				   																	cout << "Error : Transpose not defined on this type" << endl;
				   																	exit(-1);
				   																}
				   																//Generate quad for Transpose
				   																$$=$1;					
				   																type* mattrans = new type(t_mat,$1.t_exp->cols,$1.t_exp->rows);
				   																$$.addr = currentsymboltable->gentemp(*mattrans);
				   																$$.t_exp = mattrans;
				   																quads->emit(".'",$1.addr->name,$$.addr->name);
				   															}
				   ;

argument_expression_list_opt: %empty										{	$$=NULL;	}
							 |argument_expression_list 						{
							 													$$=$1;
							 												}
							 ;

argument_expression_list: assignment_expression 							{	//creates a new vector pushes the argument on a vector 																		
																				$$ = new vector<exp_attr>();
																				$$->push_back($1);
																			}
						 |argument_expression_list ',' assignment_expression{
						 														//pushes the argument on a vector 
						 														$$=$1;
						 														$$->push_back($3);
						 													}
						 ;

unary_expression: postfix_expression										{	$$ = $1;	}

		   		 |PLUSPLUS unary_expression									{	//Check if the expression needs to be dereferenced first if its a Matrix or a Pointer 
		   		 																$$=$2;
				   																$$.addr = currentsymboltable->gentemp(*$$.t_exp);

				   																if($2.isMattype==true)
				   																{	
				   																	//If it is a matrix that has to be dereferenced then it generates the appropriate quads
				   																	type* ty = new type(t_double);
				   																	quads->emit("=[]",$2.mat->name,$2.addr->name,$$.addr->name);
				   																	$$.addr->t = *ty;
				   																	$$.t_exp = ty;
				   																	$$.addr->size = ty->get_size();
				   																	quads->emit("+",$$.addr->name,"1",$$.addr->name);
				   																	quads->emit("[]=",$$.addr->name,$2.addr->name,$2.mat->name);
				   																}
				   																else if($2.isPtrtype == true)
		   		 																	{	//If it is a pointer that has to be dereferenced then it generates the appropriate quads

		   		 																		$$.isPtrtype = false;
		   		 																		$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																		quads->emit("*val",$2.addr->name,$$.addr->name);
		   		 																		quads->emit("+",$$.addr->name,"1",$$.addr->name);
		   		 																		quads->emit("*copy",$$.addr->name,$2.addr->name); 
		   		 																	}
				   																else{
				   																	quads->emit("+",$2.addr->name,"1",$2.addr->name);
				   																	quads->emit($2.addr->name,$$.addr->name);
				   																}
				   																$$.isMattype = false;
				   																$$.isConst = false;

		   		 															}

		   		 |MINMIN unary_expression 									{
		   		 																$$=$2;
				   																$$.addr = currentsymboltable->gentemp(*$$.t_exp);

				   																if($2.isMattype==true)
				   																{	//If it is a matrix that has to be dereferenced then it generates the appropriate quads
				   																	type* ty = new type(t_double);
				   																	quads->emit("=[]",$2.mat->name,$2.addr->name,$$.addr->name);
				   																	$$.addr->t = *ty;
				   																	$$.t_exp = ty;
				   																	$$.addr->size = ty->get_size();
				   																	quads->emit("-",$$.addr->name,"1",$$.addr->name);
				   																	quads->emit("[]=",$$.addr->name,$2.addr->name,$2.mat->name);
				   																}

				   																else if($2.isPtrtype == true)
		   		 																	{	//If it is a pointer that has to be dereferenced then it generates the appropriate quads
		   		 																		$$.isPtrtype = false;
		   		 																		while($$.num_stars--)
		   		 																		{
		   		 																			$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																			quads->emit("*val",$2.addr->name,$$.addr->name);
		   		 																			quads->emit("-",$$.addr->name,"1",$$.addr->name);
		   		 																			quads->emit("*copy",$$.addr->name,$2.addr->name);
		   		 																		} 
		   		 																	}
				   																else{
				   																	quads->emit("-",$2.addr->name,"1",$2.addr->name);
				   																	quads->emit($2.addr->name,$$.addr->name);
				   																}
				   																$$.isMattype = false;
				   																$$.isConst = false;


		   		 															}

		   		 |unary_operator cast_expression 							{

		   		 																if( $1 == '&') 
		   		 																{
		   		 																	//create a temporary of type pointer to the type of cast_expression
		   		 																	$$ = $2;
		   		 																	basictype t = t_pointer;
		   		 																	$$.t_exp = new type(t);
		   		 																	$$.t_exp->pointerto = $2.t_exp;
		   		 																	$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																	if($2.isMattype==false){
		   		 																		quads->emit("&",$2.addr->name,$$.addr->name);
		   		 																	}
		   		 																	else
		   		 																	{	//If we want the address of a dereferenced matrix that is essentially adding the offset to the base pointer
		   		 																			quads->emit("&",$2.mat->name,$$.addr->name);
		   		 																			quads->emit("+",$$.addr->name,$2.addr->name,$$.addr->name);
		   		 																			$$.isMattype = false;
		   		 																	}
		   		 																}
		   		 																else if($1 == '*')
		   		 																{

		   		 																	if($2.t_exp->pointerto == NULL) //if not a pointer throw error
		   		 																	{
		   		 																		cout << "Error - not a pointer";
		   		 																		exit(-1);										
		   		 																	}
		   		 																	//else I change the type of the expression to the type which the pointer points to and set isPresent = true. I also keep a count of the no. of *s encountered 
		   		 																	$$ = $2;
		   		 																	$$.t_exp = $2.t_exp->pointerto;
		   		 																	$$.isPtrtype = true;
		   		 																	$$.num_stars ++;		   		 																	
		   		 																}
		   		 																else if($1 == '+')
		   		 																{
		   		 																	//Copy the expression and generate appropriate quads only when dereferencing is needed
		   		 																	$$ = $2;
		   		 																	if($2.isMattype == true)
		   		 																	{
		   		 																		$$.isMattype = false;
		   		 																		type* ty = new type(t_double);
		   		 																		symentry* tmp = currentsymboltable->gentemp(*ty);
		   		 																		quads->emit("=[]",$2.mat->name,$2.addr->name,tmp->name);
		   		 																		$$.addr = tmp;
				   																		$$.t_exp = ty;
		   		 																	}
		   		 																	else if($2.isPtrtype == true)
		   		 																	{
		   		 																		$$.isPtrtype = false;
		   		 																		$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																		quads->emit("*val",$2.addr->name,$$.addr->name); 
		   		 																	}
		   		 																	
		   		 																}
		   		 																else if($1 == '-')
		   		 																{
		   		 																	$$=$2;
		   		 																	//generate appropriate quads if dereferencing is needed
		   		 																	if($2.isMattype == true)
		   		 																	{
		   		 																		$$.isMattype = false;
		   		 																		type* ty = new type(t_double);
		   		 																		symentry* tmp = currentsymboltable->gentemp(*ty);
		   		 																		quads->emit("=[]",$2.mat->name,$2.addr->name,tmp->name);
				   																		$$.t_exp = ty;
				   																		$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																		quads->emit("-u",tmp->name,$$.addr->name);
		   		 																	}
		   		 																	else if($2.isPtrtype == true)
		   		 																	{
		   		 																		$$.isPtrtype = false;
		   		 																		symentry* tmp= currentsymboltable->gentemp(*$$.t_exp);
		   		 																		quads->emit("*val",$2.addr->name,tmp->name);
		   		 																		$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																		quads->emit("-u",tmp->name,$$.addr->name); 
		   		 																	}
		   		 																	//Check if the expression corresponds to an address i.e. we cannot negate a pointer
		   		 																	else if((($2.isPtrtype == false && $2.t_exp->actype == t_pointer)))
		   		 																	{
		   		 																		cout << "Error - Cannot negate a pointer reference" << endl;
		   		 																		exit(-1);
		   		 																	}
		   		 																	/*else if((($2.isMattype == false && $2.t_exp->actype == t_mat)))
		   		 																	{
		   		 																		$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																		int rows = $$.addr->t.rows;
		   		 																		int cols = $$.addr->t.cols;
		   		 																		for(int i=0;i<(rows*cols);i++)
		   		 																		{
		   		 																			ostringstream s1;
		   		 																			s1 << i;
		   		 																			quads->emit("negmat",s1.str(),$$.addr->name);
		   		 																		}

		   		 																	}*/
		   		 																	else
		   		 																	{
		   		 																		//Generate appropriate quads for the negate operation if deferencing was not needed
		   		 																		$$.addr = currentsymboltable->gentemp(*$$.t_exp);
		   		 																		quads->emit("-u",$2.addr->name,$$.addr->name);
		   		 																	}
		   		 																	
		   		 																}
		   		 																$$.isConst = false;

		   		 															}
		   		 ;	

unary_operator: '&' 														{	$$ = '&';	}	
			   |'*'															{	$$ = '*';	}
			   |'+'															{	$$ = '+';	}
			   |'-'															{	$$ = '-';	}
			   ;

cast_expression: unary_expression 											{	$$ = $1;
																				
																			}

multiplicative_expression: cast_expression 									{	//If we reach here we know the matrix or pointer cannot occur on the LHS of an assignment_expression so we can dereference
																				$$=$1;
																				if($1.isMattype==true)
																				{
																					type* ty = new type(t_double);
																					$$.addr = currentsymboltable->gentemp(*ty);
																					quads->emit("=[]",$1.mat->name,$1.addr->name,$$.addr->name); 
																					$$.t_exp = ty;
																					$$.isMattype = false;
																					$$.isConst = false;
																				}
																				else if($1.isPtrtype==true)
																				{
																					$$.isPtrtype = false;
		   		 																	while($$.num_stars--)
		   		 																	{
		   		 																		type* ty = $$.addr->t.pointerto;
		   		 																		symentry* tmp= currentsymboltable->gentemp(*ty);
		   		 																		quads->emit("*val",$$.addr->name,tmp->name);
		   		 																		$$.addr = tmp;
		   		 																	}
		   		 																	$$.isConst = false; 
																				}

																			}
						  |multiplicative_expression '*' cast_expression 	{	
						  														//dereference matrices and pointers
						  														if($3.isMattype == true)
						  														{
						  															$3.isMattype = false;
						  															type* ty = new type(t_double);
						  															symentry* tmp = currentsymboltable->gentemp(*ty);
						  															quads->emit("=[]",$3.mat->name,$3.addr->name,tmp->name);
						  															$3.addr = tmp;
						  															$3.t_exp=ty;

						  														}
						  														else if($3.isPtrtype == true)
						  														{
						  															$3.isPtrtype = false;
						  															while($3.num_stars--)
		   		 																	{
			   		 																	type* ty = $3.addr->t.pointerto;
							  															symentry* tmp = currentsymboltable->gentemp(*ty);
							  															quads->emit("*val",$3.addr->name,tmp->name);
							  															$3.addr = tmp;
							  														}						  															

						  														}
						  														//We need to handle matrix multiplication differently because the typecheck in that case is different 
						  														else if($3.t_exp->actype == t_mat && $1.t_exp->actype== t_mat )
						  														{
						  															if($1.t_exp->cols == $3.t_exp->rows)
						  															{
						  																$$=$1;
						  																type* matmul = new type(t_mat,$1.t_exp->rows,$3.t_exp->cols);
						  																$$.t_exp = matmul;
						  																$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  																quads->emit("*",$1.addr->name,$3.addr->name,$$.addr->name);	
						  																$$.isConst = false;
						  															}
						  															else
						  															{
						  																yyerror("Incompatible matrix size for multiplication");
						  																exit(-1);
						  															}
						  														}
							  													else{
							  														//For all other cases we simply typecheck and generate appropriate quads for the multiplication operation
							  														if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																						typecheck(&($3),&($1));
																					else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																						typecheck(&($3),&($1));
																					else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																						typecheck(&($3),&($1));
																					else
																						typecheck(&($1),&($3));
							  														$$=$1;
						  															$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  															quads->emit("*",$1.addr->name,$3.addr->name,$$.addr->name);	
						  															$$.isConst = false;
						  														}		

						  													}

						  |multiplicative_expression '/' cast_expression 	{
						  														//dereference matrices and pointers
						  														if($3.isMattype == true)
						  														{
						  															$3.isMattype = false;
						  															type* ty = new type(t_double);
						  															symentry* tmp = currentsymboltable->gentemp(*ty);
						  															quads->emit("=[]",$3.mat->name,$3.addr->name,tmp->name);
						  															$3.addr = tmp;
						  															$3.t_exp=ty;

						  														}
						  														else if($3.isPtrtype == true)
						  														{
						  															$3.isPtrtype = false;
						  															while($3.num_stars--)
		   		 																	{
			   		 																	type* ty = $3.addr->t.pointerto;
							  															symentry* tmp = currentsymboltable->gentemp(*ty);
							  															quads->emit("*val",$3.addr->name,tmp->name);
							  															$3.addr = tmp;
							  														}						  															

						  														}
						  														//Matrix division or pointer division gives an error 
						  														else if(($3.isMattype == false && $3.t_exp->actype == t_mat)||(($3.isPtrtype == false && $3.t_exp->actype == t_pointer)))
		   		 																	{
		   		 																		cout << "Error -Pointer/Matrix divisions not supported" << endl;
		   		 																		exit(-1);
		   		 																	}
		   		 																//After handling the above intricacies we simply typecheck and generate appropriate quads for the division operation
						  														if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("/",$1.addr->name,$3.addr->name,$$.addr->name);	
						  														$$.isConst = false;		
																			}

						  |multiplicative_expression '%' cast_expression 	{	//dereference matrices and pointers
						  														if($3.isMattype == true)
						  														{
						  															$3.isMattype = false;
						  															type* ty = new type(t_double);
						  															symentry* tmp = currentsymboltable->gentemp(*ty);
						  															quads->emit("=[]",$3.mat->name,$3.addr->name,tmp->name);
						  															$3.addr = tmp;
						  															$3.t_exp=ty;

						  														}
						  														else if($3.isPtrtype == true)
						  														{
						  															$3.isPtrtype = false;
						  															while($3.num_stars--)
		   		 																	{
			   		 																	type* ty = $3.addr->t.pointerto;
							  															symentry* tmp = currentsymboltable->gentemp(*ty);
							  															quads->emit("*val",$3.addr->name,tmp->name);
							  															$3.addr = tmp;
							  														}						  															

						  														}
						  														//Matrix division or pointer division gives an error 
						  														else if(($3.isMattype == false && $3.t_exp->actype == t_mat)||(($3.isPtrtype == false && $3.t_exp->actype == t_pointer)))
		   		 																	{
		   		 																		cout << "Error -Pointer/Matrix modulo not supported" <<  endl;
		   		 																		exit(-1);
		   		 																	}
		   		 																//After handling the above intricacies we simply typecheck and generate appropriate quads for the division operation
						  														if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
						  														$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("%",$1.addr->name,$3.addr->name,$$.addr->name);		
						  														$$.isConst = false;	

						  													}


additive_expression: multiplicative_expression  							{	$$=$1;	}
					|additive_expression '+' multiplicative_expression		{	
																				//we simply typecheck, generate new temporary and generate appropriate quads for the addition operation	
																				if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("+",$1.addr->name,$3.addr->name,$$.addr->name);	
						  														$$.isConst = false;

																			}
					|additive_expression '-' multiplicative_expression		{
																				//we simply typecheck, generate new temporary and generate appropriate quads for the subtraction operation	
																				if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("-",$1.addr->name,$3.addr->name,$$.addr->name);	
						  														$$.isConst = false;
						  													}

shift_expression: additive_expression										{	$$=$1;	}
				 |shift_expression LSHIFT additive_expression				{	
				 																//Shift operation only supported for integer expressions or the ones that can be converterd to integers except double
				 																if(($1.t_exp->actype != t_integer && $1.t_exp->actype != t_char && $1.t_exp->actype != t_Bool) || ($3.t_exp->actype != t_integer && $3.t_exp->actype != t_char && $3.t_exp->actype != t_Bool))
				 																	{
				 																		cout << "Incompatible Types for Shift operation" << endl;
				 																		exit(-1);
				 																	}
				 																//After the check is done we create a temporary and generate appropriate quad
				 																if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("<<",$1.addr->name,$3.addr->name,$$.addr->name);	
						  														$$.isConst = false;

				 															}

				 |shift_expression RSHIFT additive_expression				{	//Shift operation only supported for integer expressions or the ones that can be converterd to integers except double
				 																if(($1.t_exp->actype != t_integer && $1.t_exp->actype != t_char && $1.t_exp->actype != t_Bool) || ($3.t_exp->actype != t_integer && $3.t_exp->actype != t_char && $3.t_exp->actype != t_Bool))
				 																	{
				 																		cout << "Incompatible Types for Shift operation" << endl;
				 																		exit(-1);
				 																	}
				 																//After the check is done we create a temporary and generate appropriate quad
				 																if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit(">>",$1.addr->name,$3.addr->name,$$.addr->name);
						  														$$.isConst = false;	
																			}

relational_expression: shift_expression 									{	$$=$1;	}
					  |relational_expression '<' shift_expression			{
					  															//Type check the two operations to be compared
					  															if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				//Assign the implicit boolean type to the expression
																				basictype t = t_Bool;
																				$$.t_exp = new type(t);
																				//create the truelist
																				//create the falselist
																				//Generate if goto quad
																				//Generate goto quad required when expression evaluates to false
																				$$.truelist = makelist(quads->nextinstr);				
					  															$$.falselist =makelist(quads->nextinstr+1);				
					  															quads->emit("if<",$1.addr->name, $3.addr->name,"");		
					  															quads->emit("goto","","");								
					  															$$.isConst = false;
					  															

					  														}

					  |relational_expression '>' shift_expression			{

					  															//Type check the two operations to be compared
					  															if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				//Assign the implicit boolean type to the expression
																				basictype t = t_Bool;
																				$$.t_exp = new type(t);
																				//create the truelist
																				//create the falselist
																				//Generate if goto quad
																				//Generate goto quad required when expression evaluates to false
					  															$$.truelist = makelist(quads->nextinstr);
					  															$$.falselist =makelist(quads->nextinstr+1);
					  															quads->emit("if>",$1.addr->name, $3.addr->name,"");
					  															quads->emit("goto","","");
					  															$$.isConst = false;

					  														}
					  |relational_expression LTE shift_expression			{	
					  															//Type check the two operations to be compared
					  															if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				//Assign the implicit boolean type to the expression
																				basictype t = t_Bool;
																				$$.t_exp = new type(t);
																				//create the truelist
																				//create the falselist
																				//Generate if goto quad
																				//Generate goto quad required when expression evaluates to false
					  															$$.truelist = makelist(quads->nextinstr);
					  															$$.falselist =makelist(quads->nextinstr+1);
					  															quads->emit("if<=",$1.addr->name, $3.addr->name,"");
					  															quads->emit("goto","","");
					  															$$.isConst = false;
					  														}

					  |relational_expression GTE shift_expression			{
					  															//Type check the two operations to be compared	
					  															if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));	
																				else
																					typecheck(&($1),&($3));
																				//Assign the implicit boolean type to the expression
																				basictype t = t_Bool;
																				$$.t_exp = new type(t);
																				//create the truelist
																				//create the falselist
																				//Generate if goto quad
																				//Generate goto quad required when expression evaluates to false
					  															$$.truelist = makelist(quads->nextinstr);
					  															$$.falselist =makelist(quads->nextinstr+1);
					  															quads->emit("if>=",$1.addr->name, $3.addr->name,"");
					  															quads->emit("goto","","");
					  															$$.isConst = false;

					  														}

equality_expression: relational_expression  								{	$$=$1;	}
				   |equality_expression EQUALS relational_expression 		{
				   																//Type check the two operations to be compared
				   																if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				//Assign the implicit boolean type to the expression
																				basictype t = t_Bool;
																				$$.t_exp = new type(t);
																				//create the truelist
																				//create the falselist
																				//Generate if goto quad
																				//Generate goto quad required when expression evaluates to false
					  															$$.truelist = makelist(quads->nextinstr);
					  															$$.falselist =makelist(quads->nextinstr+1);
					  															quads->emit("if==",$1.addr->name, $3.addr->name,"");
					  															quads->emit("goto","","");
					  															$$.isConst = false;
				   															}

				   |equality_expression NEQUALS relational_expression   	{
				   																//Type check the two operations to be compared
				   																if($1.t_exp->actype==t_double && $3.t_exp->actype==t_integer)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				//Assign the implicit boolean type to the expression
																				basictype t = t_Bool;
																				$$.t_exp = new type(t);
																				//create the truelist
																				//create the falselist
																				//Generate if goto quad
																				//Generate goto quad required when expression evaluates to false
					  															$$.truelist = makelist(quads->nextinstr);
					  															$$.falselist =makelist(quads->nextinstr+1);
					  															quads->emit("if!=",$1.addr->name, $3.addr->name,"");
					  															quads->emit("goto","","");
					  															$$.isConst = false;

				   															}

AND_expression: equality_expression 										{	$$=$1;	}
			   |AND_expression '&' equality_expression  					{
			   																	//Bitwise operation only supported for integer expressions or the ones that can be converterd to integers except double
			   																	if(($1.t_exp->actype != t_integer && $1.t_exp->actype != t_char && $1.t_exp->actype != t_Bool) || ($3.t_exp->actype != t_integer && $3.t_exp->actype != t_char && $3.t_exp->actype != t_Bool))
				 																	{
				 																		cout << "Incompatible Types for Shift operation";
				 																		exit(-1);
				 																	}
				 																//After the check is done we create a temporary and generate appropriate quad
				 																if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("&bit",$1.addr->name,$3.addr->name,$$.addr->name);	
						  														$$.isConst = false;
			   																}

exclusive_OR_expression: AND_expression 									{	$$=$1;	}
				        |exclusive_OR_expression '^' AND_expression  		{
				        														//Bitwise operation only supported for integer expressions or the ones that can be converterd to integers except double
				        														if(($1.t_exp->actype != t_integer && $1.t_exp->actype != t_char && $1.t_exp->actype != t_Bool) || ($3.t_exp->actype != t_integer && $3.t_exp->actype != t_char && $3.t_exp->actype != t_Bool))
				 																	{
				 																		cout << "Incompatible Types for Shift operation";
				 																		exit(-1);
				 																	}
				 																//After the check is done we create a temporary and generate appropriate quad
				 																if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("^",$1.addr->name,$3.addr->name,$$.addr->name);
						  														$$.isConst = false;

				        													}

inclusive_OR_expression: exclusive_OR_expression							{	$$=$1;	}
						|inclusive_OR_expression '|' exclusive_OR_expression{
																				//Bitwise operation only supported for integer expressions or the ones that can be converterd to integers except double
																				if(($1.t_exp->actype != t_integer && $1.t_exp->actype != t_char && $1.t_exp->actype != t_Bool) || ($3.t_exp->actype != t_integer && $3.t_exp->actype != t_char && $3.t_exp->actype != t_Bool))
				 																	{
				 																		cout << "Incompatible Types for Shift operation";
				 																		exit(-1);
				 																	}
				 																//After the check is done we create a temporary and generate appropriate quad
				 																if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_char)
																					typecheck(&($3),&($1));
																				else if($1.t_exp->actype==t_integer && $3.t_exp->actype==t_Bool)
																					typecheck(&($3),&($1));
																				else
																					typecheck(&($1),&($3));
																				$$=$1;
						  														$$.addr = currentsymboltable->gentemp(*$$.t_exp);
						  														quads->emit("|",$1.addr->name,$3.addr->name,$$.addr->name);
						  														$$.isConst = false;
																			}

logical_AND_expression: inclusive_OR_expression								{	$$=$1;	}
					   |logical_AND_expression LAND M inclusive_OR_expression	{
					   																type* t = new type(t_Bool);
					   																$$.t_exp = t;
					   																backpatch($1.truelist,$3);
					   																$$.truelist = $4.truelist;
					   																$$.falselist = merge($1.falselist,$4.falselist);
					   																$$.isConst = false;

					   															}

logical_OR_expression: logical_AND_expression 								{	$$=$1;	}
					  |logical_OR_expression LOR M logical_AND_expression 	{
					  															type* t = new type(t_Bool);
					   															$$.t_exp = t;
					  															backpatch($1.falselist,$3);
					  															$$.truelist = merge($1.truelist,$4.truelist);
					  															$$.falselist = $4.falselist;
					  															$$.isConst = false;
					  														}

conditional_expression: logical_OR_expression 								{	$$=$1;	}
					   |logical_OR_expression N '?' M expression N ':' M conditional_expression	
					   														{
					   															// First check if conditional_expression needs to be converted from Bool to int
					   															if($9.t_exp->actype == t_Bool)
					   															{
					   																bool2int(&($9));
					   															}
					   															ostringstream s1;
					   															vector<int>* l = makelist(quads->nextinstr);
					   															quads->emit("goto","","");
					   															// Check if expression($5) needs to be converted from Bool to int
					   															if($5.t_exp->actype == t_Bool)
					   															{
					   																
					   																backpatch($6,quads->nextinstr);
					   																bool2int(&($5));
					   																$6 = makelist(quads->nextinstr);
					   																quads->emit("goto","","");
					   															}
					   															//Now we typecheck and see which expression gets translated while doing the necessary backpatching
					   															if($5.t_exp->actype==t_double && $9.t_exp->actype==t_integer)
																					{
																						backpatch(l,quads->nextinstr);
																						typecheck(&($9),&($5));
																						$$.addr = currentsymboltable->gentemp(*$9.t_exp);
																						quads->emit($9.addr->name,$$.addr->name);
																						l = makelist(quads->nextinstr);
																						quads->emit("goto","","");
																						backpatch($6,quads->nextinstr);
																						quads->emit($5.addr->name,$$.addr->name);
																						l = merge(l,makelist(quads->nextinstr));
																						quads->emit("goto","","");

																					}
																				else if($5.t_exp->actype==t_integer && $9.t_exp->actype==t_char)
																					{	
																						backpatch(l,quads->nextinstr);
																						typecheck(&($9),&($5));
																						$$.addr = currentsymboltable->gentemp(*$9.t_exp);
																						quads->emit($9.addr->name,$$.addr->name);
																						l = makelist(quads->nextinstr);
																						quads->emit("goto","","");
																						backpatch($6,quads->nextinstr);
																						quads->emit($5.addr->name,$$.addr->name);
																						l = merge(l,makelist(quads->nextinstr));
																						quads->emit("goto","","");
																					}
																				else
																				{	
																					backpatch($6,quads->nextinstr);
																					typecheck(&($5),&($9));
																					$$.addr = currentsymboltable->gentemp(*$9.t_exp);
																					quads->emit($5.addr->name,$$.addr->name);
																					vector<int>* p  = makelist(quads->nextinstr);
					   																quads->emit("goto","","");
					   																backpatch(l,quads->nextinstr);
					   																quads->emit($9.addr->name,$$.addr->name);
					   																l = makelist(quads->nextinstr);
					   																quads->emit("goto","","");
					   																l = merge(l,p);												
																					
																				}
																				backpatch($2,quads->nextinstr);
																				//We convert the logical_OR_expression($1) to bool if required
																				if($1.t_exp->actype!=t_Bool)
																				{
																					int2bool(&($1));
																				}
																				//backpatch the remaining instructions
																				backpatch(l,quads->nextinstr);
																				backpatch($1.truelist,$4);
																				backpatch($1.falselist,$8);
																				$$.t_exp = $5.t_exp;
																				$$.truelist = NULL;
																				$$.truelist = NULL;
																				$$.isConst = false;

					   														}

assignment_expression: conditional_expression										{	$$=$1;	}
			          |unary_expression assignment_operator assignment_expression 	{
			          																	if($2 != '=')
			          																		cout << "Operation not supported";
			          																	else
			          																	{
			          																		/*if($1.isMattype != true && $1.t_exp->actype == t_mat)
			          																		{
			          																			cout << "Unsupported Operation - Matrix cannot be directly assigned without referencing";
			        																			exit(-1);
			          																		}*/
			          																		
			          																		//else
			          																		//{
			          																			//typecheck for assignment -> the RHS always gets converted to LHS
			          																			typecheck(&($3),&($1));
			          																			if($1.isMattype == true) //If the LHS was a matrix to be dereferenced, generate appropriate quad
			          																			{
			          																				quads->emit("[]=",$3.addr->name,$1.addr->name,$1.mat->name);
			          																			}
			          																			else if($1.isPtrtype == true)//If the LHS was a pointer to be dereferenced, generate appropriate quad
			          																			{
			          																				quads->emit("*copy",$3.addr->name,$1.addr->name);
			          																			}
			          																			else{
			          																				quads->emit($3.addr->name,$1.addr->name);
			          																			}
			          																		//}
			          																	}
			          																	$$ = $3;
			          																	$$.isConst = false;


			          																}

assignment_operator: '='													{
																				$$ = '=';
																			}
					|STAREQ													{	
																				//Not supported
																			}
					|DIVEQ													{	
																				//Not supported
																			}
					|MODEQ													{	
																				//Not supported
																			}		
					|PLUSEQ													{	
																				//Not supported
																			}
					|MINEQ													{	
																				//Not supported
																			}
					|LSHIFTEQ												{	
																				//Not supported
																			}
					|RSHIFTEQ												{	
																				//Not supported
																			}
					|ANDEQ													{	
																				//Not supported
																			}
					|POWEQ													{	
																				//Not supported
																			}	
					|OREQ													{	
																				//Not supported
																			}
					;

expression: assignment_expression 											{	$$=$1;
																				
																			}									      
	       |expression ',' assignment_expression 							{
	       																		// Not supported 
	       																	}
	       	;
constant_expression: conditional_expression 								{	$$=$1;	}
					;

M : %empty 																	{	$$ = quads->nextinstr;	}

N: %empty																	{
																				$$ = makelist(quads->nextinstr);
																				quads->emit("goto","","");
																			}

/*Declarations*/

declaration: declaration_specifiers init_declarator_list_opt ';'			{
																			}

declaration_specifiers: type_specifier										{
																				//$$=$1;
																				curr = $1; //save the current type information in  a global variable
																			}
						|type_specifier declaration_specifiers 				{
																				//Not supported
																			}

init_declarator_list_opt: %empty 											{}
					    |init_declarator_list 								{	$$=$1;	}

init_declarator_list: init_declarator 										{	$$=$1;	}
					 |init_declarator_list ',' init_declarator 				{	$$=$3;	}			

init_declarator: declarator 												{
																				$$=$1;
																				if($1.addr->t.actype == t_func)						//If the declarator was a function and it has to be declared only, then we go back to the previous symtable
																					{	
																						symboltable *temp = currentsymboltable;				
				  																		currentsymboltable = symtables.back();
				  																		symtables.pop_back();
				  																	}

																			}
				|declarator '=' initializer 								{
																				//Cannot initialize a function
																				if($1.addr->t.actype == t_func)
																					{	
																						cout << "Cannot Initialize a function" << endl;
																						exit(-1);
				  																	}
				  																//If we have a list to initalize a matrix we check if those can be assigned or not to the matrix
				  																if($3.matlist!=NULL)
				  																{
				  																	vector<double>* init = new vector<double>();
				  																	int size = $3.matlist->size();
				  																	//Check if there is a size mismatch while initalizing the matrix 
				  																	if(($1.addr->t.rows*$1.addr->t.cols)!= size)
				  																	{
				  																		cout << "Size mismatch while initalizing the matrix" << endl;
				  																		exit(-1);
				  																	}
				  																	for(int i=0;i<size;i++)
				  																	{
				  																		if((*$3.matlist)[i].t_exp->actype != t_double && (*$3.matlist)[i].t_exp->actype != t_integer)
				  																		{
				  																			cout << "Failed to initialize matrix due to type conflicts" << endl;
				  																			exit(-1);
				  																		}
				  																		double a;
				  																		if((*$3.matlist)[i].t_exp->actype == t_double)
				  																			a = (*$3.matlist)[i].addr->init.dbVal.db;
				  																		if((*$3.matlist)[i].t_exp->actype == t_integer)
				  																			{	
																								  a = (*$3.matlist)[i].addr->init.intVal;
																							}
				  																		init->push_back(a);
																						ostringstream s1;
																						s1 << i;
																						quads -> emit("[]=",(*$3.matlist)[i].addr->name ,s1.str() ,$1.addr->name);
				  																	}
				  																	/*for(int i = 0;i<size;i++)	//Deleting redundant temporaries and quads which just copy a const to a tempprary - Offset adjusted accordingly
				  																	{
				  																		symentry* tmp = currentsymboltable->symentries.back();
				  																		currentsymboltable->offset -=tmp->size;
				  																		currentsymboltable->symentries.pop_back();
				  																		count_temp--;
				  																		quads->quadarray.pop_back();
				  																		quads->nextinstr--;
				  																	}*/
				  																	initialVal i;
				  																	i.matVal = init;
				  																	$1.addr->setInitialVal(i);	//Set the initial value to a vector

				  																}
				  																else{
																					if($3.E.isConst == true && are_same_type(*($1.t_exp),*($3.E.t_exp)))   //if the value is a constant, set it to the initial value of the symbol table entry 
																					{
																						$1.addr->setInitialVal($3.E.addr->init);
																					}
																					typecheck(&($3.E),&($1));
																					quads->emit($3.E.addr->name,$1.addr->name);
																			}
																				$$=$1;

																			}	

type_specifier: VOID 														{
																				$$.t_dec = new type(t_void);
																				$$.size = 0;

																			}		
				|CHAR 														{
																				$$.t_dec = new type(t_char);
																				$$.size = 1;
																			}
																				
				|SHORT 														{
																				//Not supported
																			}	
				|INT 														{
																				$$.t_dec = new type(t_integer);
																				$$.size = 4;
																			}
				|LONG 														{
																				//Not supported
																			}	
				|FLOAT 														{
																				//Not supported
																			}
				|DOUBLE 													{
																				$$.t_dec = new type(t_double);
																				$$.size = 8;
																			}	
				|MATRIX 													{
																				$$.t_dec = new type(t_mat);
																				$$.size = -1;
																			}	
				|SIGNED 													{
																				//Not supported		
																			}
				|UNSIGNED 													{
																				//Not supported
																			}
				|BOOL 														{
																				//Not supported
																			}

declarator: pointer_opt direct_declarator 									{
																				 
																					$$=$2;
																					while(curr.t_dec->pointerto!=NULL) //If a pointer was declared I need to go back to original type of the declaration
																					{
																						curr.t_dec = curr.t_dec->pointerto;
																					}
																					if(dynallocerror == true)		//If a matrix was dynamically allocated and it was not a function then throw error 
																						{
																							cout << "Matrix needs to be statically defined" << endl;
																							exit(-1);
																						}
																				
																			}

pointer_opt : %empty 														{}
			 |pointer 														{}

direct_declarator: IDENTIFIER  												{
																				//Check if the identifier has already been declared
																				if(currentsymboltable->isPresent($1.name) || globalsymboltable->isPresent($1.name))
																				{
																					cout << "Error - Re-dlecaration of identifier:" << $1.name << endl;
																					exit(-1);
																				}
																				//If the type is matrix then there is chance that the matrix is being dynamically allocated
																				if(curr.t_dec->actype == t_mat)
																				{
																					dynallocerror = true;
																				}
																				//Create a new symboltable entry for the identifier with the current type of the declaration
																				$$.addr =currentsymboltable->lookup($1.name);
																				currentsymboltable->update($$.addr,*curr.t_dec);
																				$$.t_exp = curr.t_dec;
																				$$.truelist = NULL;
																				$$.falselist = NULL;
																				func_name = $$.addr->name;	//There is a possibilty it might be a function
																			}	 
				  |'(' declarator ')' 										{	$$=$2;	}
				  |IDENTIFIER '[' assignment_expression ']' '[' assignment_expression ']' 	
				  															{
				  																if(currentsymboltable->isPresent($1.name) || globalsymboltable->isPresent($1.name)) //Check for Re-dlecaration of identifier
																				{
																					cout << "Error - Re-dlecaration of identifier:" << $1.name << endl;
																					exit(-1);
																				}
				  																if(curr.t_dec->actype != t_mat)	//If the current type is not a matrix throw an error
				  																{
				  																	cout << "Error : Expected a matrix type " << endl;
				  																	exit(-1);		
				  																}
				  																else
				  																{
				  																	//Create a symboltable entry for the matrix and assign its rows and columns 
				  																	if($3.isConst && $6.isConst)
				  																		{
				  																			if($3.t_exp->actype == t_integer && $6.t_exp->actype == t_integer)	
				  																			{
				  																				int rows = $3.addr->init.intVal;
				  																				int cols = $6.addr->init.intVal;
				  																				type* matfull = new type(t_mat,rows,cols);
				  																				$$.addr = currentsymboltable -> lookup($1.name);
				  																				currentsymboltable->update($$.addr,*matfull);
				  																				$$.t_exp = matfull;
				  																				$$.truelist = NULL;
				  																				$$.falselist = NULL;
				  																			}
				  																			else //Something like m[2.4][3.4] will throw error
				  																			{
				  																				cout << "Error: Only integer constant can index a matrix" << endl;
				  																				exit(-1);
				  																			}
				  																		} 
				  																	else{
				  																		cout << "Error: Dyanamic allocation not supported" << endl;
				  																		exit(-1);
				  																	}
				  																}
				  															}	
				  |direct_declarator '(' K parameter_type_list ')' 			{
				  																	
				  																curr = $3;											//restore the type of the declaration
				  																symboltable *temp = currentsymboltable;				//save the currentsymboltable
				  																currentsymboltable = symtables.back();				//pop back the previous table and store in the currentsymboltable
				  																symtables.pop_back();
				  																currentsymboltable->offset -= $1.t_exp->size;		//to change the type of the id to function we need to recalculate the offsets
				  															 	type* f = new type(t_func);							//create a new function type
				  																currentsymboltable->update($1.addr,*f);				//update the type of the symboltable entry
				  																$1.addr->t.retval = curr.t_dec;						//make the current declaration type as the return type
				 																$1.t_exp = &($1.addr->t);
				  																//temp->name = "ST(" + $1.addr->name + ")";			//name the nested table
				  																temp->name = $1.addr->name;
																				$1.addr->nested_table = temp;						//save the pointer to the nested_table		
				  																symtables.push_back(currentsymboltable);			//Go back to the symboltable of the function
				  																currentsymboltable = temp;							
				  																$$=$1;
				  																dynallocerror = false;					

				  															}
				  |direct_declarator '(' identifier_list ')'				{
				  																
				 	 														}
				  |direct_declarator '(' K ')'	 							{
				  																curr = $3;											//restore the type of the declaration
				  																symboltable *temp = currentsymboltable;				//save the currentsymboltable
				  																currentsymboltable = symtables.back();				//pop back the previous table and store in the currentsymboltable
				  																symtables.pop_back();
				  																currentsymboltable->offset -= $1.t_exp->size;		//to change the type of the id to function we need to recalculate the offsets
				  															 	type* f = new type(t_func);							//create a new function type
				  																currentsymboltable->update($1.addr,*f);				//update the type of the symboltable entry
				  																$1.addr->t.retval = curr.t_dec;						//make the current declaration type as the return type
				 																$1.t_exp = &($1.addr->t);
				  																//temp->name = "ST(" + $1.addr->name + ")";			//name the nested table
				  																temp->name = $1.addr->name;
																				$1.addr->nested_table = temp;						//save the pointer to the nested_table
				  																symtables.push_back(currentsymboltable);			//Go back to the symboltable of the function
				  																currentsymboltable = temp;			
				  																$$=$1;			
				  																dynallocerror = false;					
					


				  															}											

		

pointer: '*' pointer_opt 													{
																				type* t = new type(t_pointer);
																				t->pointerto = curr.t_dec;
																				curr.t_dec = t;
																			}		

parameter_type_list: parameter_list 										{	
																				$$=$1;	
																			}

parameter_list: parameter_declaration 										{
																				$$=$1;
																			}
		 	   |parameter_list ',' parameter_declaration 					{	
		 	   																	$$=$3;	
		 	   																}


parameter_declaration: declaration_specifiers declarator 					{
																				$$ = $2;
																				$$.addr->isParam = true;
																				//curr = $1;

																			}
					  |declaration_specifiers 								{
					  															//Not supported
					  														}

K: %empty																	{ 	
																				$$ = curr;
																				symboltable* newtable = new symboltable("");
																				symtables.push_back(currentsymboltable);
																				currentsymboltable = newtable;
																				symentry* tmp=currentsymboltable->lookup("retval");
																				tmp->t = *curr.t_dec;
																				quads->emit("f()","",func_name);
																				dynallocerror = false;	

																			}	

identifier_list: IDENTIFIER  												{
																				//Not supported
																			}	
				|identifier_list ',' IDENTIFIER 							{
																				//Not supported
																			}

initializer: assignment_expression 											{
																				$$.E=$1;
																				$$.matlist = NULL;
																			}	
			|'{' initializer_row_list '}' 									{
																				$$.matlist = $2;
																			}

initializer_row_list: initializer_row 										{
																				$$=$1;
																			}	
					 |initializer_row_list ';' initializer_row 				{
					 															$1->insert($1->end(),$3->begin(),$3->end());
					 															$$ = $1;
																			}

initializer_row: designation_opt initializer 								{
																				if($2.matlist != NULL)
																				{
																					cout << "Error" << endl;
																					exit(-1);
																				}
																				if($2.E.isConst != true)
																				{
																					cout << "Matrix can be initialized with constant values only" << endl;
																					exit(-1);
																				}
																				if($2.E.t_exp->actype == t_integer)
																				{
																					$2.E.t_exp = new type(t_double);
																					currentsymboltable->offset -= 4;
																					currentsymboltable->update($2.E.addr,*$2.E.t_exp);
																					$2.E.addr->init.dbVal.db = $2.E.addr->init.intVal;
																				}
																				$$ = new vector<exp_attr>();
																				$$->push_back($2.E);
																			} 
				|initializer_row ',' designation_opt initializer 			{
																				if($4.matlist != NULL)
																				{
																					cout << "Error" << endl;
																					exit(-1);
																				}
																				if($4.E.isConst != true)
																				{
																					cout << "Matrix can be initialized with constant values only" << endl;
																					exit(-1);
																				}
																				if($4.E.t_exp->actype == t_integer)
																				{
																					$4.E.t_exp = new type(t_double);
																					currentsymboltable->offset -= 4;
																					currentsymboltable->update($4.E.addr,*$4.E.t_exp);
																					$4.E.addr->init.dbVal.db = $4.E.addr->init.intVal;
																				}
																				$$->push_back($4.E);

																			}				
 
designation_opt: %empty														{}
				|designation  												{}	

designation: designator_list '=' 											{
																				//Not supported
																			}

designator_list: designator 												{
																				//Not supported
																			}
				 |designator_list designator  								{
				 																//Not supported
				 															}

designator: '[' constant_expression ']' 									{
																				//Not supported
																			}
		   |'.' IDENTIFIER 													{
		   																		//Not supported
		   																	}	

/*Statements*/

statement: labeled_statement											 	{
																				//Not supported
																			}			
		  |compound_statement												{
		  																		$$=$1;

		  																	}
		  |expression_statement												{
		  																		$$=NULL;

		  																	}		
		  |selection_statement												{
		  																		$$=$1;
		  																	}
																				
		  |iteration_statement												{
		  																		$$=$1;
		  																		
		  																	}
		  |jump_statement													{
		  																		$$=$1;

		  																	}	

labeled_statement: IDENTIFIER ':' statement 								{
																				//Not supported
																			}
				  |CASE constant_expression ':' statement 					{
				  																//Not supported
				  															}
				  |DEFAULT ':' statement 									{
				  																//Not supported
				  															}

compound_statement: '{' block_item_list_opt '}'								{
																				$$=$2;
																			}

block_item_list_opt : %empty												{
																				$$=NULL;
																			}
					 |block_item_list 										{
					 															$$=$1;
					 														}

block_item_list: block_item 												{
																				$$=$1;
																			}
				|block_item_list M block_item 								{
																				backpatch($1,$2);
																				$$=$3;
																			}

block_item: declaration  													{	$$=NULL;	}
		   |statement 														{
		   																		$$=$1;
		   																	}		

expression_statement: expression_opt ';'									{
																			}		

selection_statement: IF'(' expression N ')' M statement 						{	
																				$$ = makelist(quads->nextinstr);
																				$$ = merge($$,$7);
																				quads->emit("goto","","");
																				backpatch($4,quads->nextinstr);
																				if($3.t_exp->actype!=t_Bool)
																				{
																					int2bool(&($3));
																				}
																				backpatch($3.truelist,$6);
																				$$ = merge($3.falselist,$$);

																			}

					|IF'(' expression N ')' M statement N ELSE M statement 	{
																				$$ = makelist(quads->nextinstr);
																				$$ = merge($$,$7);
																				$$ = merge($$,$8);
																				$$ = merge($$,$11);
																				quads->emit("goto","","");
																				backpatch($4,quads->nextinstr);
																				if($3.t_exp->actype!=t_Bool)
																				{
																					int2bool(&($3));
																				}
																				backpatch($3.truelist,$6);
																				backpatch($3.falselist,$10);

																			}				
					|SWITCH '(' expression ')' statement 					{
																				//Not supported
																			}

iteration_statement: WHILE'(' M expression N ')' M statement 										{
																										ostringstream s1;
																										s1 << $3;
																										quads->emit("goto","",s1.str());
																										backpatch($5,quads->nextinstr);
																										if($4.t_exp->actype!=t_Bool)
																										{
																											int2bool(&($4));
																										}
																										$$ = $4.falselist;
																										backpatch($4.truelist,$7);
																										backpatch($8,$3);
																									}	
																								
					|DO M statement WHILE '(' M expression ')' ';'									{
																										if($7.t_exp->actype!=t_Bool)
																										{
																											int2bool(&($7));
																										}
																										$$ = $7.falselist;
																										backpatch($7.truelist,$2);
																										backpatch($3,$6);
																									}

					|FOR '(' expression_opt ';' M expression_opt N';' M expression_opt N')' M statement 	{
																												ostringstream s1;
																												s1 << $9;
																												quads->emit("goto","",s1.str());
																												backpatch($11,$5);
																												backpatch($7,quads->nextinstr);
																												if($6.t_exp->actype!=t_Bool)
																												{
																													int2bool(&($6));
																												}
																												backpatch($6.truelist,$13);
																												backpatch($14,$9);
																												$$ = $6.falselist;

																											}
					|FOR '(' declaration expression_opt ';' expression_opt ')' statement  			{
																										//Not supported
																									}

jump_statement: GOTO IDENTIFIER';' 											{
																				//Not supported
																			}
				|CONTINUE';' 												{
																				//Not supported
																			}
				|BREAK';'													{
																				//Not supported
																			}	
				|RETURN expression ';' 										{
																				symentry* tmp = currentsymboltable->lookup("retval");
																				//If thr fucntion was of a matrix type we set the size of the return value matrix after parsing the function and seeing what is the size of the matrix being returned
																				if(tmp->t.actype == t_mat && $2.addr->t.actype==t_mat)		
																				{
																					tmp->t.rows = $2.addr->t.rows;
																					tmp->t.cols = $2.addr->t.cols;
																					tmp->t.size = tmp->t.get_size();
																					string s = currentsymboltable->name;
																					int len = s.length();
																					s = s.substr(3,len-3-1);
																					symentry* temp = globalsymboltable->lookup(s);
																					temp->t.retval = &($2.addr->t);
																					tmp->t = $2.addr->t;
																					tmp->size = tmp->t.get_size(); 
																					quads->emit("ret","",$2.addr->name);
																				}
																				else{ //Otherwise we typecheck with return type and Generate appropriate quad
																					exp_attr* ret = new exp_attr();
																					ret->t_exp = &(tmp->t);
																					typecheck(&($2),ret);
																					quads->emit("ret","",$2.addr->name);
																				}
																				$$ = NULL;
																			}

				|RETURN ';'													{
																				symentry* tmp = currentsymboltable->lookup("retval");
																				if(tmp->t.actype == t_void)  //if only return; is used then the function must be of void type
																					quads->emit("ret","","");
																				else
																					{
																						cout << "Return type does not match" << endl;
																						exit(-1);
																					}
																				$$ = NULL;

																			}

expression_opt: %empty														{

																			}
			   |expression 													{
			   																	$$=$1;
			   																}

/* External Definitions */

translation_unit: external_declaration										{
																				
																			}
				 |translation_unit external_declaration						{
				 																
				 }

external_declaration: function_definition									{}
					 |declaration 											{}

function_definition: declaration_specifiers declarator declaration_list_opt compound_statement  	{ 	//augmentation
																										symboltable *temp = currentsymboltable;				
				  																						currentsymboltable = symtables.back();		//go back to the original globalsymboltable
				  																						symtables.pop_back();								
				  																						backpatch($4,quads->nextinstr);				//backpatch any dangling gotos 
				  																	
																									}



declaration_list_opt: %empty												{}
					 |declaration_list 										{}

declaration_list : declaration 												{}
				  |declaration_list declaration 							{}



%%

int yyerror(string err){
  cout << err;
  return -1;
}

