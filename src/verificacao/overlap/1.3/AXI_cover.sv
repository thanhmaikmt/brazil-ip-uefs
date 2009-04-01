

module AXI_cover(input clk, ready, valid);
  int count_ready_stable, count_valid_stable;
  int ready_up, ready_down, valid_up, valid_down;
  
  always@(posedge clk) begin
      count_ready_stable += 1;
      count_valid_stable += 1;
  end
  
  covergroup c_up;
      coverpoint ready_up {
          bins up[] = { 0 };
          option.at_least = 1;
      }
      coverpoint valid_up {
          bins up[] = { 0 };
          option.at_least = 1;
      }
  endgroup
  c_up c_up_i = new;
          
  covergroup c_down;
      coverpoint ready_down {
          bins dn[] = { 0 };
          option.at_least = 1;
      }
      coverpoint valid_down {
          bins dn[] = { 0 };
          option.at_least = 1;
      }
  endgroup
  c_down c_down_i = new;
          
  always @(ready) begin
      if(ready) begin
          ready_up = count_ready_stable;
          c_up_i.sample();
      end
      else begin
          ready_down = count_ready_stable;
          c_down_i.sample();
      end
      count_ready_stable = 0;
  end
  
  always @(valid) begin
      if(valid) begin
          valid_up = count_valid_stable;
          c_up_i.sample();
      end
      else begin
          valid_down = count_valid_stable;
          c_down_i.sample();
      end
      count_valid_stable = 0;
  end

endmodule
