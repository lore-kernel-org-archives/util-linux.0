Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35748 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdFGP1v (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Jun 2017 11:27:51 -0400
Received: by mail-qt0-f196.google.com with SMTP id x58so1814246qtc.2
        for <util-linux@vger.kernel.org>; Wed, 07 Jun 2017 08:27:51 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <42e92093-bed4-daa0-e2cd-f90205e17f8b@gmx.com>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
 <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de> <0035d164-75ac-f892-2cbe-0fb8184116cb@gmx.com>
 <201706061010.07911.sweet_f_a@gmx.de> <de2ea265-ed30-8493-7267-a113b9140a5d@gmx.com>
 <42e92093-bed4-daa0-e2cd-f90205e17f8b@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 7 Jun 2017 16:27:50 +0100
Message-ID: <CAG27Bk1W2wbSFoAV70EpWT-2USvmuHV_muC2DODr8ALODTS_ww@mail.gmail.com>
Subject: Re: [PATCH 6/6] misc: fix some warnings
To: J William Piggott <elseifthen@gmx.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 June 2017 at 20:17, J William Piggott <elseifthen@gmx.com> wrote:
>
>
> On 06/06/2017 02:18 PM, J William Piggott wrote:
>>
>>
>> On 06/06/2017 04:10 AM, Ruediger Meier wrote:
>>> On Thursday 01 June 2017, J William Piggott wrote:
>>>> On 05/31/2017 09:08 PM, Ruediger Meier wrote:
>>>>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>>>
>>>>  8< ---
>>>>
>>>>> diff --git a/lib/plymouth-ctrl.c b/lib/plymouth-ctrl.c
>>>>> index 75d8b93..0e60341 100644
>>>>> --- a/lib/plymouth-ctrl.c
>>>>> +++ b/lib/plymouth-ctrl.c
>>>>> @@ -85,7 +85,8 @@ static int open_un_socket_and_connect(void)
>>>>>     * Please note that the PLYMOUTH_SOCKET_PATH has a
>>>>>     * leading NULL byte to mark it as an abstract socket
>>>>>     */
>>>>> -  ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1
>>>>> + strlen(su.sun_path+1)); +        ret = connect(fd, (const struct
>>>>> sockaddr *) &su,
>>>>> +                offsetof(struct sockaddr_un, sun_path) + 1 +
>>>>> strlen(su.sun_path+1));
>>>>
>>>>         ^^^^^^^^^^^^^^ whitespace
>>>>
>>>>  8< ---
>>>
>>> What would be the right whitespace style? I've made one indentation
>>> (tab) and some spaces to align the broken line regarding  "connect(".
>>>
>>> I'm using tab only for indentation but not for alignment, to let it look
>>> nice independently of editors tab witdth. Is that wrong?
>>
>> I wouldn't call it 'wrong'. To my knowledge, it is not the style this
>> project uses. Eight spaces should be a tab. You have one tab and 14
>> spaces, it should be 2 tabs and 6 spaces. Actually, the Linux kernel
>> style guide (the chosen style guide for util-linux) says no spaces are
>> allowed for c indentation, but Karel seems to make an exception for that.
>>
>> I have git configured to highlight eight spaces and when I looked at
>> this commit with 'git show' that line lit up in red. Something I do
>> not normally see happen in this project.
>>
>
> I forgot to mention, the line in question exceeds 80 columns and should
> be split again (the line changed in last.c wraps now also).

I would say 80 columns is preferred, but we should not be too strict with it.
Sometimes code does look better when wider, and that's fine.

And the spaces vs tab. Yep, we should prefer tabs but sometimes accidents
happen. Calling these 'wrong' is too strong. This is yet another preference
thing, and if someone notices during review spaces where there should be
tabs then that's a good review commend and should be fixed. But I would
not go so far that existing whitespaces ought to be fixed without a change
to code line where they are.

util-linux $ for i in $(find . -name '*.c'); do unexpand $i > $i- ; mv
$i- $i; done
util-linux $ git diff --stat
[...]
 79 files changed, 799 insertions(+), 799 deletions(-)

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
