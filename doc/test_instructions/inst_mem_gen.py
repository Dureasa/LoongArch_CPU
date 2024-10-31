
PREFIX = """`timescale 1ns / 1ps

module inst_mem(
    input [31:0]        addr,  // 32 bit address
    output reg [31:0]   inst   // 32 bit data output
);
    
    reg [31:0] mem [0:511];
    integer i;
    
    // Initialize
    initial begin\n"""
SUFFIX = """; i < 512; i = i + 1) begin
            mem[i] = 32'd0;
        end
    end

    wire [31:0] pc;
    assign pc = addr >> 2;

    // Read operation
    always @(*) begin
        inst = mem[pc];
    end 

endmodule"""

def read_file_to_string(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
            return content
    except FileNotFoundError:
        print(f"文件 {file_path} 未找到。")
        return None
    except Exception as e:
        print(f"读取文件时发生错误：{e}")
        return None


def main():
    output = PREFIX
    file_path = 'C:/Users/lyh16/Desktop/loongarch_cpu/doc/test_instructions/alu_test.coe'
    raw_content = read_file_to_string(file_path)
#     raw_content = """memory_initialization_radix=2;
# memory_initialization_vector=
# 00000010100000000000000000000001,
# 00000010100000000000010000000010,
# 00000010100000000010100000000011,
# 01011000000000000001100001100000,
# 00000000000100000000100000100100,
# 00000000000100000000000001000001,
# 00000000000100000000000010000010,
# 00000010101111111111110001100011,
# 01011011111111111110110000000000,
# 00000000000000000000000000000000,
# 01011011111111111111110000000000;"""
    instructions = [line.strip() for line in raw_content[61:-1].split(',')]
    pre = '        mem[' 
    for i in range(len(instructions)):
        tmp = pre + str(i) + "] = 32'b" + instructions[i] + ';\n'
        output += tmp

    output += "        for (i = " + str(len(instructions))
    output += SUFFIX
    print(output)


if __name__ == '__main__':
    main()