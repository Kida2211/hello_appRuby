require  "test_helper"

class  ApplicationHelperTest  <  ActionView :: TestCase 
  test  "full title helper"  do 
    assert_equal  (Write the code) ,  full_title 
    assert_equal  (Write the code) ,  full_title ( "Help" ) 
  end 
end
