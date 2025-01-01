#include "Vseq_top.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#define CLOCK_POS \
    top->clk_i = !top->clk_i; \
    top->eval()
#define CLOCK_NEG \
    top->eval(); \
    tfp->dump(local_time++); \
    top->clk_i = !top->clk_i; \
    top->eval(); \
    tfp->dump(local_time++)
#define CLOCK_DELAY(x) \
    for (int xx=0; xx < x; xx++) { \
        top->clk_i = !top->clk_i; \
        CLOCK_NEG; \
    }
#define WAIT(x, y) \
    while (1) { \
        if (x == y) break; \
        CLOCK_DELAY(1); \
    }

int main(int argc, char **argv) {
    int i, local_time = 0;

    Verilated::commandArgs(argc, argv);
    Vseq_top* top = new Vseq_top;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("seq_top.vcd");

    CLOCK_POS;
    top->rst_ni = 0;
    top->a = 0;
    top->b = 0;
    top->start = 0;
    CLOCK_NEG;

    CLOCK_DELAY(5);

    CLOCK_POS;
    top->rst_ni = 1;
    CLOCK_NEG;

    CLOCK_DELAY(10);
    printf("Test case 1 start\n");

    CLOCK_POS;
    top->a = 15;
    top->b = 13;
    top->start = 1;
    CLOCK_NEG;
    CLOCK_POS;
    top->start = 0;
    CLOCK_NEG;

    WAIT(top->finish, 1);

    CLOCK_DELAY(10);
    printf("Test case 2 start\n");

    CLOCK_POS;
    top->a = 0xfedcba98;
    top->b = 0x76543210;
    top->start = 1;
    CLOCK_NEG;
    CLOCK_POS;
    top->start = 0;
    CLOCK_NEG;

    WAIT(top->finish, 1);

    CLOCK_DELAY(10);
    printf("Test finished\n");

    tfp->close();
    delete top;
    delete tfp;
    return 0;

}
