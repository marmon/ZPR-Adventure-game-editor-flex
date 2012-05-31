package utils.stack
{
    public class Stack
    {
        private var first : Node;
        
        public function isEmpty ():Boolean
        {
            return first == null;
        }
        
        public function push (data : Object):void
        {
            var oldFirst : Node = first;
            first = new Node ();
            first.data = data;
            first.next = oldFirst;
        }
        
        public function pop () : Object 
        {
            if (isEmpty ())
            {
                //trace ("Error: \n\t Objects of type Stack must containt data before you attempt to pop");
                //return;
            }
            var data:Object = first.data;
            first = first.next;
            return data;
        }
        
        public function peek () : Object 
        {
            if (isEmpty ())
            {
                //trace ("Error: \n\t Objects of type Stack must containt data before you attempt to peek");
                //return;
            }
            return first.data;
        }
        
        public function toArray():Array 
        {     
            var current:Node = first;
            var a:Array = [];     
            while (current != null)     
            {         
                a.push(current.data);         
                current = first.next;     
            }     
            return a.reverse(); 
        }
    }
}