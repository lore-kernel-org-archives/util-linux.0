Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <00f84d55-932f-854f-2492-f77e119913e2@gmx.de>
References: <20170917184902.1218-1-kerolasa@iki.fi> <20170917184902.1218-2-kerolasa@iki.fi>
 <20170918090755.mxogoxmodbq2hlzp@ws.net.home> <00f84d55-932f-854f-2492-f77e119913e2@gmx.de>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 20 Sep 2017 12:56:32 +0100
Message-ID: <CAG27Bk0UEWPyG7w7jCeVmwmZ1O7gtAcOpBy7S_=JMV-707-KPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools: update git-version-gen from gnulib
To: =?UTF-8?Q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On 18 September 2017 at 14:36, R=C3=BCdiger Meier <sweet_f_a@gmx.de> wrote:
> On 09/18/2017 11:07 AM, Karel Zak wrote:
>> On Sun, Sep 17, 2017 at 07:49:01PM +0100, Sami Kerola wrote:
>>> from-gnulib-commit: e277cd7c6cf6435d9d4d380fd6cef0510e3f5afe
>>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>> ---
>>>   tools/git-version-gen | 137
>>> +++++++++++++++++++++++++++++++++++++-------------
>>>   1 file changed, 102 insertions(+), 35 deletions(-)
>>
>>
>> I'm not sure about this. Did you check all the changes?
>>
>> We have some local changes to the file, see
>>
>>      git whatchanged tools/git-version-gen
>>      It would be nice to be sure that all works as expected.
>
>
> I wouldn't touch this neither. Last year I've reviewed that really carefu=
lly
> while fixing some issues with broken version numbers, see 85004b14 and al=
so
> the other ones from the same patch-set. Seems that Sami's patch would rev=
ert
> some of these changes.
>
> At that time there was also the question why not following gnulib and I
> tried to
> justify this like this:
>
> https://www.spinics.net/lists/util-linux-ng/msg13374.html

Hi Rudi and Karel,

Oh yes, I did not think too much how this was modified to be
util-linux specific.
Adding a comment that will tell it clearly that one should not simply sync =
from
gnulib would be nice.

--=20
Sami Kerola
http://www.iki.fi/kerolasa/
