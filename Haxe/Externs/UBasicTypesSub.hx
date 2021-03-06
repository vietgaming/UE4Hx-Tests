import unreal.*;

@:umodule("HaxeUnitTests")
@:glueCppIncludes("BasicTypesSub.h")
@:uextern extern class UBasicTypesSub1 extends UBasicTypesUObject {
  public var isSub1:Bool;
  static function CreateFromCpp():UBasicTypesSub1;
  function writeToByteArray(arr:ByteArray, loc:Int, what:UInt8):Bool;
}

@:umodule("HaxeUnitTests")
@:glueCppIncludes("BasicTypesSub.h")
@:uextern extern class UBasicTypesSub2 extends UBasicTypesUObject implements IBasicType2 {
  public var isSub2:Bool;
  static function CreateFromCpp():UBasicTypesSub2;

  function doSomething():IBasicType2;
  function getSubName():unreal.FString;
  function getSomeInt():Int;
}

@:umodule("HaxeUnitTests")
@:glueCppIncludes("BasicTypesSub.h")
@:uextern extern class UBasicTypesSub3 extends UBasicTypesSub2 {
  public var isSub3:Bool;
  static function CreateFromCpp():UBasicTypesSub3;
}

@:umodule("HaxeUnitTests")
@:glueCppIncludes("BasicType2.h")
@:uextern extern interface IBasicType2 {
  function doSomething():IBasicType2;
  function getSubName():unreal.FString;
  function getSomeInt():Int;
}
