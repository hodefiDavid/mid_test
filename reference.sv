//referance model class for alu

class reference;
transaction res;
function new();
    reset();
    this.res = new();
endfunction

function void reset();

endfunction

function transaction step(transaction trans);
    this.res = new();
    this.res.A = trans.A;
    this.res.B = trans.B;
    this.res.MODE = trans.MODE;

    //the function of the ALU
    //  select = 0 -> a + b;
    //  select = 1 -> a - b;
    //  select = 2 -> ++a;
    //  select = 3 -> ++b;

    case ( this.res.MODE)
        0 : begin
            this.res.Y = this.res.A + this.res.B;
        end
        1 : begin
            this.res.Y =this.res.A - this.res.B;
        end
        2 : begin
            this.res.Y = this.res.A + 1;
        end
        3 : begin
            this.res.Y = this.res.B + 1;
        end
        default : begin
            this.res.Y = 0;
        end
        
    endcase

    return this.res;

endfunction

 endclass

