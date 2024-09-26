using System;
using UnityEngine;

namespace VisCircle
{
	public class PowerUpAnimation : MonoBehaviour
	{
		public enum RotationType
		{
			SelfAxis,
			WorldAxis
		}

		[SerializeField]
		private bool _animateRotation = true;

		public Vector3 rotationSpeedsInDegreePerSecond;

		public RotationType rotationType;

		[SerializeField]
		private bool _animateScale = true;

		public float scaleMin = 0.5f;

		public float scaleMax = 1.5f;

		public float scaleCycleDuration = 5f;

		[SerializeField]
		private bool _animateYOffset = true;

		public float yOffsetAmplitude = 1f;

		public float yOffsetCycleDuration = 5f;

		private Vector3 _startLocalPosition;

		private Quaternion _startLocalRotation;

		private Vector3 _startLocalScale;

		private Transform _transform;

		private void Awake()
		{
			_transform = GetComponent<Transform>();
			_startLocalPosition = _transform.localPosition;
			_startLocalRotation = _transform.localRotation;
			_startLocalScale = _transform.localScale;
		}

		private void Update()
		{
			if (_animateYOffset)
			{
				float y = (yOffsetCycleDuration == 0f) ? 0f : (Mathf.Sin(Time.time / yOffsetCycleDuration * (float)Math.PI * 2f) * yOffsetAmplitude);
				base.transform.localPosition = _startLocalPosition + new Vector3(0f, y, 0f);
			}
			if (_animateScale)
			{
				float d;
				if (scaleCycleDuration != 0f)
				{
					float t = Mathf.InverseLerp(-1f, 1f, Mathf.Sin(Time.time / scaleCycleDuration * (float)Math.PI * 2f));
					d = Mathf.Lerp(scaleMin, scaleMax, t);
				}
				else
				{
					d = 1f;
				}
				base.transform.localScale = d * _startLocalScale;
			}
			if (_animateRotation)
			{
				if (rotationType == RotationType.WorldAxis)
				{
					base.transform.Rotate(rotationSpeedsInDegreePerSecond * Time.deltaTime, Space.World);
				}
				else
				{
					base.transform.Rotate(rotationSpeedsInDegreePerSecond * Time.deltaTime, Space.Self);
				}
			}
		}

		public bool GetAnimateScale()
		{
			return _animateScale;
		}

		public void SetAnimateScale(bool newAnimateScale)
		{
			_animateScale = newAnimateScale;
			if (!_animateScale && Application.isPlaying)
			{
				base.transform.localScale = _startLocalScale;
			}
		}

		public bool GetAnimateYOffset()
		{
			return _animateYOffset;
		}

		public void SetAnimateYOffset(bool newAnimateYOffset)
		{
			_animateYOffset = newAnimateYOffset;
			if (!_animateYOffset && Application.isPlaying)
			{
				base.transform.localPosition = _startLocalPosition;
			}
		}

		public bool GetAnimateRotation()
		{
			return _animateRotation;
		}

		public void SetAnimateRotation(bool newAnimateRotation)
		{
			_animateRotation = newAnimateRotation;
			if (!_animateRotation && Application.isPlaying)
			{
				base.transform.localRotation = _startLocalRotation;
			}
		}
	}
}
