using System;
using System.Collections;
using UnityEngine;

namespace Invector
{
	public static class vExtensions
	{
		public static bool isChild(this Transform me, Transform target)
		{
			if (!target)
			{
				return false;
			}
			string name = target.gameObject.name;
			Transform transform = me.FindChildByNameRecursive(name);
			if (transform == null)
			{
				return false;
			}
			return transform.Equals(target);
		}

		public static Transform FindChildByNameRecursive(this Transform me, string name)
		{
			if (me.name == name)
			{
				return me;
			}
			for (int i = 0; i < me.childCount; i++)
			{
				Transform child = me.GetChild(i);
				Transform transform = child.FindChildByNameRecursive(name);
				if (transform != null)
				{
					return transform;
				}
			}
			return null;
		}

		public static T[] Append<T>(this T[] arrayInitial, T[] arrayToAppend)
		{
			if (arrayToAppend == null)
			{
				throw new ArgumentNullException("The appended object cannot be null");
			}
			if (arrayInitial is string || arrayToAppend is string)
			{
				throw new ArgumentException("The argument must be an enumerable");
			}
			T[] array = new T[arrayInitial.Length + arrayToAppend.Length];
			arrayInitial.CopyTo(array, 0);
			arrayToAppend.CopyTo(array, arrayInitial.Length);
			return array;
		}

		public static Vector3 NormalizeAngle(this Vector3 eulerAngle)
		{
			Vector3 vector = eulerAngle;
			if (vector.x > 180f)
			{
				vector.x -= 360f;
			}
			else if (vector.x < -180f)
			{
				vector.x += 360f;
			}
			if (vector.y > 180f)
			{
				vector.y -= 360f;
			}
			else if (vector.y < -180f)
			{
				vector.y += 360f;
			}
			if (vector.z > 180f)
			{
				vector.z -= 360f;
			}
			else if (vector.z < -180f)
			{
				vector.z += 360f;
			}
			return new Vector3(vector.x, vector.y, vector.z);
		}

		public static Vector3 Difference(this Vector3 vector, Vector3 otherVector)
		{
			return otherVector - vector;
		}

		public static void SetActiveChildren(this GameObject gameObjet, bool value)
		{
			IEnumerator enumerator = gameObjet.transform.GetEnumerator();
			try
			{
				while (enumerator.MoveNext())
				{
					Transform transform = (Transform)enumerator.Current;
					transform.gameObject.SetActive(value);
				}
			}
			finally
			{
				IDisposable disposable;
				if ((disposable = (enumerator as IDisposable)) != null)
				{
					disposable.Dispose();
				}
			}
		}

		public static void SetLayerRecursively(this GameObject obj, int layer)
		{
			obj.layer = layer;
			IEnumerator enumerator = obj.transform.GetEnumerator();
			try
			{
				while (enumerator.MoveNext())
				{
					Transform transform = (Transform)enumerator.Current;
					transform.gameObject.SetLayerRecursively(layer);
				}
			}
			finally
			{
				IDisposable disposable;
				if ((disposable = (enumerator as IDisposable)) != null)
				{
					disposable.Dispose();
				}
			}
		}

		public static float ClampAngle(float angle, float min, float max)
		{
			do
			{
				if (angle < -360f)
				{
					angle += 360f;
				}
				if (angle > 360f)
				{
					angle -= 360f;
				}
			}
			while (angle < -360f || angle > 360f);
			return Mathf.Clamp(angle, min, max);
		}

		public static void Slerp(this vThirdPersonCameraState to, vThirdPersonCameraState from, float time)
		{
			to.Name = from.Name;
			to.forward = Mathf.Lerp(to.forward, from.forward, time);
			to.right = Mathf.Lerp(to.right, from.right, time);
			to.defaultDistance = Mathf.Lerp(to.defaultDistance, from.defaultDistance, time);
			to.maxDistance = Mathf.Lerp(to.maxDistance, from.maxDistance, time);
			to.minDistance = Mathf.Lerp(to.minDistance, from.minDistance, time);
			to.height = Mathf.Lerp(to.height, from.height, time);
			to.fixedAngle = Vector2.Lerp(to.fixedAngle, from.fixedAngle, time);
			to.smoothFollow = Mathf.Lerp(to.smoothFollow, from.smoothFollow, time);
			to.xMouseSensitivity = Mathf.Lerp(to.xMouseSensitivity, from.xMouseSensitivity, time);
			to.yMouseSensitivity = Mathf.Lerp(to.yMouseSensitivity, from.yMouseSensitivity, time);
			to.yMinLimit = Mathf.Lerp(to.yMinLimit, from.yMinLimit, time);
			to.yMaxLimit = Mathf.Lerp(to.yMaxLimit, from.yMaxLimit, time);
			to.xMinLimit = Mathf.Lerp(to.xMinLimit, from.xMinLimit, time);
			to.xMaxLimit = Mathf.Lerp(to.xMaxLimit, from.xMaxLimit, time);
			to.rotationOffSet = Vector3.Lerp(to.rotationOffSet, from.rotationOffSet, time);
			to.cullingHeight = Mathf.Lerp(to.cullingHeight, from.cullingHeight, time);
			to.cullingMinDist = Mathf.Lerp(to.cullingMinDist, from.cullingMinDist, time);
			to.cameraMode = from.cameraMode;
			to.useZoom = from.useZoom;
			to.lookPoints = from.lookPoints;
			to.fov = Mathf.Lerp(to.fov, from.fov, time);
		}

		public static void CopyState(this vThirdPersonCameraState to, vThirdPersonCameraState from)
		{
			to.Name = from.Name;
			to.forward = from.forward;
			to.right = from.right;
			to.defaultDistance = from.defaultDistance;
			to.maxDistance = from.maxDistance;
			to.minDistance = from.minDistance;
			to.height = from.height;
			to.fixedAngle = from.fixedAngle;
			to.lookPoints = from.lookPoints;
			to.smoothFollow = from.smoothFollow;
			to.xMouseSensitivity = from.xMouseSensitivity;
			to.yMouseSensitivity = from.yMouseSensitivity;
			to.yMinLimit = from.yMinLimit;
			to.yMaxLimit = from.yMaxLimit;
			to.xMinLimit = from.xMinLimit;
			to.xMaxLimit = from.xMaxLimit;
			to.rotationOffSet = from.rotationOffSet;
			to.cullingHeight = from.cullingHeight;
			to.cullingMinDist = from.cullingMinDist;
			to.cameraMode = from.cameraMode;
			to.useZoom = from.useZoom;
			to.fov = from.fov;
		}

		public static ClipPlanePoints NearClipPlanePoints(this Camera camera, Vector3 pos, float clipPlaneMargin)
		{
			ClipPlanePoints result = default(ClipPlanePoints);
			Transform transform = camera.transform;
			float f = camera.fieldOfView / 2f * ((float)Math.PI / 180f);
			float aspect = camera.aspect;
			float nearClipPlane = camera.nearClipPlane;
			float num = nearClipPlane * Mathf.Tan(f);
			float num2 = num * aspect;
			num *= 1f + clipPlaneMargin;
			num2 *= 1f + clipPlaneMargin;
			result.LowerRight = pos + transform.right * num2;
			result.LowerRight -= transform.up * num;
			result.LowerRight += transform.forward * nearClipPlane;
			result.LowerLeft = pos - transform.right * num2;
			result.LowerLeft -= transform.up * num;
			result.LowerLeft += transform.forward * nearClipPlane;
			result.UpperRight = pos + transform.right * num2;
			result.UpperRight += transform.up * num;
			result.UpperRight += transform.forward * nearClipPlane;
			result.UpperLeft = pos - transform.right * num2;
			result.UpperLeft += transform.up * num;
			result.UpperLeft += transform.forward * nearClipPlane;
			return result;
		}

		public static HitBarPoints GetBoundPoint(this BoxCollider boxCollider, Transform torso, LayerMask mask)
		{
			HitBarPoints hitBarPoints = HitBarPoints.None;
			BoxPoint boxPoint = boxCollider.GetBoxPoint();
			Ray ray = new Ray(boxPoint.top, boxPoint.top - torso.position);
			Ray ray2 = new Ray(torso.position, boxPoint.center - torso.position);
			Ray ray3 = new Ray(torso.position, boxPoint.bottom - torso.position);
			Debug.DrawRay(ray.origin, ray.direction, Color.red, 2f);
			Debug.DrawRay(ray2.origin, ray2.direction, Color.green, 2f);
			Debug.DrawRay(ray3.origin, ray3.direction, Color.blue, 2f);
			float maxDistance = Vector3.Distance(torso.position, boxPoint.top);
			if (Physics.Raycast(ray, out RaycastHit hitInfo, maxDistance, mask))
			{
				hitBarPoints |= HitBarPoints.Top;
				Debug.Log(hitInfo.transform.name);
			}
			maxDistance = Vector3.Distance(torso.position, boxPoint.center);
			if (Physics.Raycast(ray2, out hitInfo, maxDistance, mask))
			{
				hitBarPoints |= HitBarPoints.Center;
				Debug.Log(hitInfo.transform.name);
			}
			maxDistance = Vector3.Distance(torso.position, boxPoint.bottom);
			if (Physics.Raycast(ray3, out hitInfo, maxDistance, mask))
			{
				hitBarPoints |= HitBarPoints.Bottom;
				Debug.Log(hitInfo.transform.name);
			}
			return hitBarPoints;
		}

		public static BoxPoint GetBoxPoint(this BoxCollider boxCollider)
		{
			BoxPoint result = default(BoxPoint);
			result.center = boxCollider.transform.TransformPoint(boxCollider.center);
			Vector3 lossyScale = boxCollider.transform.lossyScale;
			float y = lossyScale.y;
			Vector3 size = boxCollider.size;
			float num = y * size.y;
			Ray ray = new Ray(result.center, boxCollider.transform.up);
			result.top = ray.GetPoint(num * 0.5f);
			result.bottom = ray.GetPoint(0f - num * 0.5f);
			return result;
		}

		public static Vector3 BoxSize(this BoxCollider boxCollider)
		{
			Vector3 lossyScale = boxCollider.transform.lossyScale;
			float x = lossyScale.x;
			Vector3 size = boxCollider.size;
			float x2 = x * size.x;
			Vector3 lossyScale2 = boxCollider.transform.lossyScale;
			float z = lossyScale2.z;
			Vector3 size2 = boxCollider.size;
			float z2 = z * size2.z;
			Vector3 lossyScale3 = boxCollider.transform.lossyScale;
			float y = lossyScale3.y;
			Vector3 size3 = boxCollider.size;
			float y2 = y * size3.y;
			return new Vector3(x2, y2, z2);
		}

		public static bool Contains(this Enum keys, Enum flag)
		{
			if (keys.GetType() != flag.GetType())
			{
				throw new ArgumentException("Type Mismatch");
			}
			return (Convert.ToUInt64(keys) & Convert.ToUInt64(flag)) != 0;
		}
	}
}
