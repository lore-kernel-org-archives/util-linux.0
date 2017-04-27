Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170424101040.snryxu4sndqtyzza@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi> <20170423205821.7444-4-kerolasa@iki.fi>
 <20170424101040.snryxu4sndqtyzza@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 27 Apr 2017 22:13:57 +0100
Message-ID: <CAG27Bk24B71HAfC3r9T_fK=hUw5vzXnT0xiSNHqqLpGudrY2zg@mail.gmail.com>
Subject: Re: [PATCH 03/10] docs: raw devices are deprecated
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 24 April 2017 at 11:10, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 23, 2017 at 09:58:14PM +0100, Sami Kerola wrote:
>> Tell in manual page that one should use open(2) O_DIRECT flag rather than
>> raw device.
>
> Maybe you want to see "git log disk-utils/raw.8", raw devices are not
> deprecated any more. See kernel commit abd4aa5a97ebc0efb9a7fbc98ef0bcf39266fadf.

How about not saying 'deprecated' but hinting O_DIRECT is better?

https://github.com/kerolasa/lelux-utiliteetit/commit/9cd7d4dad4c2753d14e125c7ea2af941a2c11be0

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
