module MemoryWriteMonitor(
    `ifdef USE_POWER_PINS
       inout vccd1,  // User area 1 1.8V power
       inout vssd1,  // User area 1 digital ground
     `endif
    
    output wire [12:0]io_oeb,
    output wire [9:0]io_ieb,
    
    input clk,                  // Clock input
    input rst,                  // Reset input
    input [3:0] writeAddress,   // Write address input
    input [3:0] writeData,      // Write data input
    input [1:0] writeModuleID,  // Module ID input
    output reg unauthorizedWriteAlert,        // Unauthorized write alert signal
    output reg [1:0] unauthorizedModuleID,    // Unauthorized module ID signal
    output reg [3:0] unauthorizedWriteAddress, // Unauthorized write address signal
    output reg [3:0] unauthorizedWriteData,    // Unauthorized write data signal
    output reg alertValid,       // Alert valid signal
    output reg blockData         // Block data signal
);

    assign io_oeb=13'b0000000000000;
    assign io_ieb=10'b1111111111;
  

 // Parameterss
    parameter MAX_AUTHORIZED_MODULES = 4;

    // Internal registers
    reg [3:0] authorizedModuleMemory [0:MAX_AUTHORIZED_MODULES-1];
    reg [1:0] authorizedModuleIDs [0:MAX_AUTHORIZED_MODULES-1];
    reg [2:0] numAuthorizedModules;
    reg [2:0] unauthorizedWriteIndex;
    reg unauthorizedWriteDetected;
    reg [31:0]i;
    // Initialize authorized module data on reset
    always @(posedge clk) 
    begin
        if (rst) begin
            // Reset internal registers
            numAuthorizedModules <= 0;
            unauthorizedWriteIndex <= 0;
            unauthorizedWriteDetected <= 0;

            // Initialize specific entries to non-zero values (customize as needed)
            authorizedModuleMemory[0] <= 4'b1010; // Example authorized memory region
            authorizedModuleIDs[0] <= 2'b01;      // Example authorized module ID
            
            authorizedModuleMemory[1] <= 4'b1100; // Additional authorized memory region
            authorizedModuleIDs[1] <= 2'b10;      // Additional authorized module ID
            
           authorizedModuleMemory[2] <= 4'b0000; // Additional authorized memory region
            authorizedModuleIDs[2] <= 2'b00;  
            
            authorizedModuleMemory[3] <= 4'b0000; // Additional authorized memory region
            authorizedModuleIDs[3] <= 2'b00;  
            
            // Initialize other entries (if needed) to zero or non-zero values as required
        end else begin
            // Initialize the number of authorized modules (customize as needed)
            numAuthorizedModules <= 2; // Set the number of authorized modules
            
             unauthorizedWriteDetected <= 1; // Assume it's unauthorized

            for (i = 0; i < 4; i = i + 1) begin
                if (writeModuleID == authorizedModuleIDs[i] && writeData == authorizedModuleMemory[i]) begin
                    unauthorizedWriteDetected <= 0; // Reset if it's authorized
                end
        end
    end
 end
    

    // Alert generation and output logic
  always @(*) begin
        if (unauthorizedWriteDetected) begin
            // Unauthorized write detected
            unauthorizedWriteAlert <= 1;
            unauthorizedModuleID <= writeModuleID;
            unauthorizedWriteAddress <= writeAddress;
            unauthorizedWriteData <= writeData;
            alertValid <= 1;
            blockData <= 1;
        end 
        else 
        begin
            // No unauthorized write detected
            unauthorizedWriteAlert <= 0;
            unauthorizedModuleID <= 2'b00;
            unauthorizedWriteAddress <= 4'b0000;
            unauthorizedWriteData <= 4'b0000;
            alertValid <= 0;
            blockData <= 0;
        end
    end

endmodule

