package com.pomodo.model {
    public class Task {
        [Bindable]
        public var name:String;
            
        public function Task(name:String = "") {
            this.name = name;
        }
    }
}