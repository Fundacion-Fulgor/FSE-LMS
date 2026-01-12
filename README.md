# FSE-LMS

This project implements a Fractionally Spaced Equalizer (FSE) with Least Mean Square (LMS) algorithm in time domain.

<img width="250" height="200" alt="image" src="https://github.com/user-attachments/assets/5cbe7ae9-24c1-484a-a3ae-2647a0723893" />
<img width="1450" height="1148" alt="image" src="https://github.com/user-attachments/assets/3e9826cd-57f4-444b-a090-21c3fcaf746f" />

### How does it work?

An input signal coming from the channel, with ISI + AWGN, enters to an equalizer that works at Tclk/2 (twice as fast as the clock), that is, at twice the symbol rate.
The output goes through a Slicer and an error signal is calculated (error = decision - output). That signal is used to update the weights or taps (coefficients) of the equalizer giving the next expression:

*w[n+1] = w[n] + 2 * mu * e * x[n]*
