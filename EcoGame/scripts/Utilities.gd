extends Node

class_name Utilities


static func getFirstChildOfType(parentNode:Node, type):
	for children in parentNode.get_children() :
		if is_instance_of(children,type):
			return children
	print("No child of type " + var_to_str(type) + " found ! check for missing nodes or bad calls.")

static func GetListoFChildOfType(parentNode:Node, type):
	var childOfTypeList = []
	for children in parentNode.get_children() :
		if (is_instance_of(children,type)):
			childOfTypeList.append(children)
	
	if (childOfTypeList == []):
		push_error("No child of type " + var_to_str(type) + " found ! check for missing nodes or bad calls.")
	return childOfTypeList

static func CreateInstance(sceneName:String, caller:Node, constructionParameters:Array = []):
	var scene = load(sceneName);
	var instance = scene.instantiate();
	
	if constructionParameters != [] :

		var sceneConstructorMethodArguments = GetMethodInfo(instance,"set_values").args;
		
		if sceneConstructorMethodArguments == null:
			push_error("Method set_values doesn't exist");

		if (constructionParameters.size() == sceneConstructorMethodArguments.size()) :
			for i in constructionParameters.size():
				if !(typeof(constructionParameters[i]) == sceneConstructorMethodArguments[i].type) :
					push_error("Construction parameters are the wrong type, at index " + str(i));
			
			instance.callv("set_values", constructionParameters);
			
		else :
			push_error("Construction parameters are not the same number as required !");
		
	caller.add_child(instance);
	return instance;

static func GetMethodInfo(object:Node, methodName:String):
	
	var selectedMethod;
	
	for method in object.get_script().get_script_method_list():
		if method.name == methodName:
			selectedMethod = method;
	
	if selectedMethod == null : 
		push_error("No method called " + methodName + " in object " + object.name + "!");
	
	return selectedMethod;
