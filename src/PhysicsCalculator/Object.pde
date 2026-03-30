import bRigid.*;
import javax.vecmath.Matrix4f;
import javax.vecmath.Vector3f;
import com.bulletphysics.linearmath.Transform;

public abstract class Object {
  float x, y, z, mass, radius, width, height, depth;

  String type;

  color col;

  BObject body;

  void display(boolean showOutlines) {

    Transform trans = body.rigidBody.getWorldTransform(new Transform());
    Matrix4f mat = new Matrix4f();
    trans.getMatrix(mat);

    if (type.equals("Box")) {
      BBox b = (BBox) body;
      pushMatrix();
      translate(b.getPosition().x, b.getPosition().y, b.getPosition().z);
      applyMatrix(
        mat.m00, mat.m01, mat.m02, 0,
        mat.m10, mat.m11, mat.m12, 0,
        mat.m20, mat.m21, mat.m22, 0,
        0, 0, 0, 1
        );
      fill(col);
      if (showOutlines) {
        stroke(0);
      } else {
        noStroke();
      }
      box(width, height, depth);
      popMatrix();
      noStroke();
    } else if (type.equals("Sphere")) {
      BSphere s = (BSphere) body;
      pushMatrix();
      translate(s.getPosition().x, s.getPosition().y, s.getPosition().z);
      applyMatrix(
        mat.m00, mat.m01, mat.m02, 0,
        mat.m10, mat.m11, mat.m12, 0,
        mat.m20, mat.m21, mat.m22, 0,
        0, 0, 0, 1
        );
      fill(col);
      if (showOutlines) {
        stroke(0);
      } else {
        noStroke();
      }
      sphere(radius);
      popMatrix();
      noStroke();
    }

    if (this instanceof DynamicObject) {
      x = body.getPosition().x;
      y = body.getPosition().y;
      z = body.getPosition().z;
    }
  }

  void displayBRigid() {
    body.display();
  }
}
