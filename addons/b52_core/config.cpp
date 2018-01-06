class CfgPatches
{
    class B52
    {
        name      = "Badca52's Core System";
        author    = "Badca52";
        authorUrl = "https://github.com/Badca52";

        version         = "0.22";
        requiredVersion = 0.22;
        requiredAddons[] = {"cba_main"};
    };
};

class CfgFunctions
{
    class B52_Core_Module
    {
        class Functions
        {
            file = "\b52_core\functions";
            class init 
            {
                preInit = 1;
            };
        };
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class B52: NO_CATEGORY
    {
        displayName = "B52";
    };
};
