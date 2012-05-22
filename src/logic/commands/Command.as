package logic.commands
{
    public interface Command
    {
        function execute():void;
        function rollback():void;
    }
}