Vim�UnDo� �?����.���߫]�ꑃ���]9I      7        replace_engine = { ["sed"] = { cmd = "gsed" } }   	   #                       e�t�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             e�U�     �                   5��                                                  �                                              �        8                  8                      �        7                  7                      �        6                  6                      �        5                  5                      �        4                 4                     �        5              
   5              
       �        ?                 ?                      �                         B                      �                        B                      �                         E                      �                        E                      �                         H                      �                         G                      �                          F                      �                         E                      �                         D                      �                          C                      �                         B                      �                          @                      �        ?                  ?                      �        ?                 ?                      �                         B                      �                          @                      �        ?                  ?                      �        ?                 ?                      �                         B                      �                         A                      �                          @                      �        ?                  ?                      �        ?                 ?                      �                         B                      �                        B                      �                         D                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             e�U�     �                --5��                          @                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e�U�     �                -5��                          @                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e�U�     �                 -- �               �               5��                          @                      �                         B                      �                          @                      �                          @                      �                         A                      �                         @                     �                         H                      �                          I                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             e�U�     �                 �             �               return {5��                         H                      �                          I                      �                        K               Y      �                         �                     �                         �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             e�U�    �                 ?-- Telescope stuff could be migrated here once it's fully done    return {     {     -- SEARCH AND REPLACE     "nvim-pack/nvim-spectre",   -  dependencies = { "nvim-lua/plenary.nvim" },     config = function()       require("spectre").setup({   5      replace_engine = { ["sed"] = { cmd = "gsed" } }       })   $    vim.keymap.set("n", "<leader>S",   /      "<Cmd>lua require('spectre').open()<CR>",   &      { desc = "search and replace" })     end   }    }5��                         M                     �                         g                     �                         �                     �                         �                     �                         �                     �                         �                     �    	                     &                    �    
                     /                    �                         V                    �                         �                    �                         �                    �                          �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             e�V    �                 } 5��                         �                     5�_�         
             !    ����                                                                                                                                                                                                                                                                                                                               !          !       V   !    e�pu     �   
             &      vim.keymap.set("n", "<leader>S",   1        "<Cmd>lua require('spectre').open()<CR>",   (        { desc = "search and replace" })5��    
                      /      �               5�_�                          ����                                                                                                                                                                                                                                                                                                                               !          !       V   !    e�p�    �   
                  �             �   
          5��    
                      /                     �    
                     /                    �    
                     5                     �    
                    5              	      5�_�                            ����                                                                                                                                                                                                                                                                                                                               !          !       V   !    e�p�    �                 ?-- Telescope stuff could be migrated here once it's fully done    return {     {       -- SEARCH AND REPLACE       "nvim-pack/nvim-spectre",   /    dependencies = { "nvim-lua/plenary.nvim" },       config = function()          require("spectre").setup({   7        replace_engine = { ["sed"] = { cmd = "gsed" } }         })   T      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {       desc = "Toggle Spectre"   })   fvim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {        desc = "Search current word"   })   Yvim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {        desc = "Search current word"   })   kvim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {   #    desc = "Search on current file"   })       end     }   }5��                         �                    �                          �                     �                          �                     �                                             �                          ?                     �                          H                     �                         �                    �                          �                     �                          �                     �                         H                    �                          p                     5�_�                          ����                                                                                                                                                                                                                                                                                                                                                v       e�rY     �             5��                          y                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       e�r\     �                �             5��                         y              �       5�_�                       "    ����                                                                                                                                                                                                                                                                                                                                                v       e�re     �               p     vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {5��       "                 �                    5�_�                       #    ����                                                                                                                                                                                                                                                                                                                                                v       e�ro     �               p     vim.keymap.set('n', '<leader>Sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {5��       #                 �                    5�_�                       $    ����                                                                                                                                                                                                                                                                                                                                                v       e�rw     �               p     vim.keymap.set('n', '<leader>Sc', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {5��       $                  �                     5�_�                       W    ����                                                                                                                                                                                                                                                                                                                                                v       e�r�     �               q     vim.keymap.set('n', '<leader>Scf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {5��       W                  �                     5�_�                   	   #    ����                                                                                                                                                                                                                                                                                                                            	   #       	   #       V   #    e�s�    �      
         7        replace_engine = { ["sed"] = { cmd = "gsed" } }5��                         �       8       ;       5�_�                             ����                                                                                                                                                                                                                                                                                                                                                V       e�t�    �                  ?-- Telescope stuff could be migrated here once it's fully done    return {     {       -- SEARCH AND REPLACE       "nvim-pack/nvim-spectre",   /    dependencies = { "nvim-lua/plenary.nvim" },       config = function()          require("spectre").setup({   :        -- replace_engine = { ["sed"] = { cmd = "gsed" } }         })   T      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {           desc = "Toggle Spectre"         })   l      vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {   $        desc = "Search current word"         })   _      vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {   $        desc = "Search current word"         })   q      vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {   '        desc = "Search on current file"         })   a     vim.keymap.set('n', '<leader>Scf', '<cmd>lua require("spectre").open_file_search({})<CR>', {   '        desc = "Search on current file"         })       end     }   }5��                                        q      5�_�                       $    ����                                                                                                                                                                                                                                                                                                                                                v       e�s�     �               %        desc = "Search current word"j5��       $                  �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       e�rZ     �             �               r       vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {   '        desc = "Search on current file"         })    })5��                        r              �       5�_�                          ����                                                                                                                                                                                                                                                                                                                                                v       e�rU     �             �               r       vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {   '        desc = "Search on current file"         })    })5��                        r              �       5�_�                       "    ����                                                                                                                                                                                                                                                                                                                               "          $       v   $    e�p�     �               o      vim.keymap.set('n', '<leaderp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {5��       "                 �                    5�_�                          ����                                                                                                                                                                                                                                                                                                                               !          !       V   !    e�p}     �                   �                   u5��                          7                     �                         ;                     5�_�                           ����                                                                                                                                                                                                                                                                                                                               !          !       V   !    e�pw     �   
                  �             �   
            ,            vim.keymap.set("n", "<leader>S",   1        "<Cmd>lua require('spectre').open()<CR>",   (        { desc = "search and replace" })    �               u5��    
                      /                     �    
                     /                    �    
                     5              �       �                          �                     5�_�          	      
      !    ����                                                                                                                                                                                                                                                                                                                               !          !       V   !    e�ph     �   
           �             �   
            T    envim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {       desc = "Toggle Spectre"   })   fvim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {        desc = "Search current word"   })   Yvim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {        desc = "Search current word"   })   kvim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {   #    desc = "Search on current file"   })d5��    
                      /      �               �    
                    5              	      5�_�             
   	          ����                                                                                                                                                                                                                                                                                                                                                 v        e�o�     �               +        "<Cmd>lua require('u').open()<CR>",5��                        q                    5�_�              	             ����                                                                                                                                                                                                                                                                                                                                                 v        e�o�     �               ,        "<Cmd>lua require(iwe').open()<CR>",5��                        p                    5��