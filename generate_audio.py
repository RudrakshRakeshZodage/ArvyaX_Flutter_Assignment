import wave
import struct
import math

def generate_audible_wav(filename, frequency=440, duration_seconds=10, type='sine'):
    sample_rate = 44100
    n_channels = 1
    sampwidth = 2
    n_frames = duration_seconds * sample_rate

    with wave.open(filename, 'w') as wav_file:
        wav_file.setnchannels(n_channels)
        wav_file.setsampwidth(sampwidth)
        wav_file.setframerate(sample_rate)
        
        for i in range(n_frames):
            t = float(i) / sample_rate
            if type == 'sine':
                # Simple sine wave
                value = int(16000 * math.sin(2.0 * math.pi * frequency * t))
            elif type == 'pulse':
                # Low frequency pulse
                value = int(16000 * math.sin(2.0 * math.pi * frequency * t) * (0.5 + 0.5 * math.sin(2.0 * math.pi * 0.5 * t)))
            else:
                value = 0
                
            data = struct.pack('<h', value)
            wav_file.writeframesraw(data)

if __name__ == '__main__':
    # Different frequencies for different moods
    configs = [
        ('assets/audio/forest.wav', 150, 'pulse'),   # Low earthy hum
        ('assets/audio/ocean.wav', 100, 'sine'),    # Deep water hum
        ('assets/audio/sleep.wav', 60, 'sine'),     # Sub-bass sleep tone
        ('assets/audio/reset.wav', 440, 'sine'),    # Clear morning tone
        ('assets/audio/zen.wav', 200, 'pulse'),     # Meditative pulse
        ('assets/audio/cosmic.wav', 80, 'pulse')    # Deep space pulse
    ]
    
    import os
    if not os.path.exists('assets/audio'):
        os.makedirs('assets/audio')
        
    for f, freq, t in configs:
        generate_audible_wav(f, frequency=freq, type=t)
        print(f"Generated audible {f} at {freq}Hz")
