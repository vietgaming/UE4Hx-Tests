package entry;
import repl.ReplTypes;
import buddy.*;
import unreal.*;

@:uclass class AClientServerEntryPoint extends AActor {
  private var didTick = false;
  private var beganPlay = false;
  public function new(wrapped) {
    super(wrapped);
    this.PrimaryActorTick.bCanEverTick = true;
  }

  override public function BeginPlay() {
    super.BeginPlay();
    beganPlay = true;
  }

  override public function Tick(deltaTime:Float32) {
    super.Tick(deltaTime);
    if (!beganPlay) {
      return;
    }

    if (didTick) {
      return;
    }
    didTick = true;

    buddy.BuddySuite.useDefaultTrace = true;
    var found:AReplicationTest = cast UObject.StaticFindObjectFast(AReplicationTest.StaticClass(), this.GetOuter(), "TheReplActor", false, false, 0);

    var reporter = new buddy.reporting.TraceReporter();

    var runner = new buddy.SuitesRunner([new repl.TestReplication(found)], reporter);
    var curPass:Null<Int> = Std.parseInt(haxe.macro.Compiler.getDefine("pass"));
    var nextPass:Null<Int> = null;
    if (curPass == 2) {
      nextPass = curPass + 1;
    }

    trace('running replication pass $curPass');

    runner.run().then(function(_) {
      cpp.vm.Gc.run(true);
      cpp.vm.Gc.run(true);
      var success = !runner.failed();
      trace('replication tests success=$success');

      if (Sys.getEnv("CI_RUNNING") == "1") {
#if WITH_EDITOR
        if (GetWorld().IsPlayInEditor()) {
          if (!success) {
            trace('Fatal', 'Test failed. Exiting');
            // the only way to make sure that UE exits with a non-0 code is to actually exit ourselves
            Sys.exit(curPass == null ? 10 : curPass);
          }

          // Timer.delay(1, function() {
          //   if (!this.isValid()) {
          //     return;
          //   }
            var pc = UGameplayStatics.GetPlayerController(GetWorld(), 0);
            if (pc != null) {
              pc.ConsoleCommand("Exit", true);
            }
          // });

          return;
        }
#end
      }
    });
  }
}
