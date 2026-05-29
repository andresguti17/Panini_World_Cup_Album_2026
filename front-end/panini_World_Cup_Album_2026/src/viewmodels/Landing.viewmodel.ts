import { useRef, useEffect } from 'react';
import { Animated } from 'react-native';
import { COUNTRIES } from '../view/screen/Landing/LandingScreen.data';

export function useLandingViewModel() {

  const b1 = useRef(new Animated.Value(0)).current;
  const b2 = useRef(new Animated.Value(0)).current;
  const b3 = useRef(new Animated.Value(0)).current;
  const b4 = useRef(new Animated.Value(0)).current;

  const translateX  = useRef(new Animated.Value(0)).current;
  const ITEM_WIDTH  = 180;
  const TOTAL_WIDTH = COUNTRIES.length * ITEM_WIDTH;

  useEffect(() => {
    const anim = (val: Animated.Value, duration: number) =>
      Animated.loop(
        Animated.sequence([
          Animated.timing(val, { toValue: 1, duration, useNativeDriver: true }),
          Animated.timing(val, { toValue: 0, duration, useNativeDriver: true }),
        ]),
      );

    Animated.parallel([
      anim(b1, 5000),
      anim(b2, 7000),
      anim(b3, 6000),
      anim(b4, 4200),
    ]).start();

    const run = () => {
      translateX.setValue(0);
      Animated.timing(translateX, {
        toValue:         -TOTAL_WIDTH,
        duration:        COUNTRIES.length * 1500,
        useNativeDriver: true,
      }).start(({ finished }) => { if (finished) run(); });
    };
    run();
  }, []);

  const move = (val: Animated.Value, range: number) =>
    val.interpolate({ inputRange: [0, 1], outputRange: [0, range] });

  return { b1, b2, b3, b4, move, translateX, ITEM_WIDTH };
}