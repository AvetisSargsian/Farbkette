import controllers.LoaderController;
import controllers.UserInputController;
import controllers.ViewsController;

import models.GameModel;

[RegisterClass(type="models.GameModel")]
public var gameModelRef:Class = GameModel;

[RegisterClass(type="controllers.ViewsController")]
public var viewsControllerRef:Class = ViewsController;

[RegisterClass(type="controllers.LoaderController")]
public var loaderControllerRef:Class = LoaderController;

[RegisterClass(type="controllers.UserInputController")]
public var UserInputControllerRef:Class = UserInputController;

