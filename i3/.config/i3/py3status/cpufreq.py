'''
Created on 30 dic 2018

@author: oggei
'''
from glob import glob

#GOVERNOR_PATH = '/sys/devices/system/cpu/*/cpufreq/scaling_governor'
CURFREQ_PATH = '/sys/devices/system/cpu/*/cpufreq/scaling_cur_freq'
NOTURBO_PATH = '/sys/devices/system/cpu/intel_pstate/no_turbo'


class Py3status:

    cache_timeout = 5
    markup = 'none'

    def cpufreq(self):
        #govs = set(open(x).read().strip()
        #           for x
        #           in glob(GOVERNOR_PATH))
        #assert len(govs) == 1
        #governor = govs.pop()

        cur_freqs = glob(CURFREQ_PATH)
        cores = len(cur_freqs)

        cur_freq = sum([int(open(x).read().strip())
                        for x
                        in cur_freqs]) / 1000000.0 / cores

        turbo = '' # ' T ' if '0' in open(NOTURBO_PATH).read() else ''

        if self.markup == 'pango':
            #if governor == 'powersave':
            color = '#aaffaa'
            #else:
            #    color = '#ff0000'
            full_text = f'<span color="{color}" font_family="FontAwesome" size="smaller">\uf2db</span> {cur_freq:.2f}'
            if turbo:
                full_text += '<span font_family="FontAwesome"> \uf0e7</span>'
        else:
            full_text = f'{cur_freq:.2f} [{governor.upper()[0]}]{turbo}'

        return {'full_text': full_text,
                'cached_until': self.py3.time_in(self.cache_timeout)
                }


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
