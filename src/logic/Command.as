package logic
{
    public interface Command
    {
        function execute():void;
        function rollback():void;
    }
}