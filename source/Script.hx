package;

import hscript.InterpEx;
import sys.io.File;

class HScript {
        public var interp:InterpEx = new InterpEx();
        public var instance:Dynamic;

        public function new(path:String) {
                try
                {
                        interp.addModule(Paths.hscriptContent(path));
                        instance = interp.createScriptClassInstance(Paths.hscript(path));
                }
                catch (e)
                {
                        trace(e.message);
                }
        }
}