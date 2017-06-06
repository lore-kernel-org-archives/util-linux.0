Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:64644 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751239AbdFFSSj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Jun 2017 14:18:39 -0400
Subject: Re: [PATCH 6/6] misc: fix some warnings
To: Ruediger Meier <sweet_f_a@gmx.de>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
 <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de>
 <0035d164-75ac-f892-2cbe-0fb8184116cb@gmx.com>
 <201706061010.07911.sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <de2ea265-ed30-8493-7267-a113b9140a5d@gmx.com>
Date: Tue, 6 Jun 2017 14:18:32 -0400
MIME-Version: 1.0
In-Reply-To: <201706061010.07911.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/06/2017 04:10 AM, Ruediger Meier wrote:
> On Thursday 01 June 2017, J William Piggott wrote:
>> On 05/31/2017 09:08 PM, Ruediger Meier wrote:
>>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>>
>>  8< ---
>>
>>> diff --git a/lib/plymouth-ctrl.c b/lib/plymouth-ctrl.c
>>> index 75d8b93..0e60341 100644
>>> --- a/lib/plymouth-ctrl.c
>>> +++ b/lib/plymouth-ctrl.c
>>> @@ -85,7 +85,8 @@ static int open_un_socket_and_connect(void)
>>>  	 * Please note that the PLYMOUTH_SOCKET_PATH has a
>>>  	 * leading NULL byte to mark it as an abstract socket
>>>  	 */
>>> -	ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1
>>> + strlen(su.sun_path+1)); +	ret = connect(fd, (const struct
>>> sockaddr *) &su,
>>> +	              offsetof(struct sockaddr_un, sun_path) + 1 +
>>> strlen(su.sun_path+1));
>>
>>         ^^^^^^^^^^^^^^ whitespace
>>
>>  8< ---
> 
> What would be the right whitespace style? I've made one indentation 
> (tab) and some spaces to align the broken line regarding  "connect(".
> 
> I'm using tab only for indentation but not for alignment, to let it look 
> nice independently of editors tab witdth. Is that wrong?

I wouldn't call it 'wrong'. To my knowledge, it is not the style this
project uses. Eight spaces should be a tab. You have one tab and 14
spaces, it should be 2 tabs and 6 spaces. Actually, the Linux kernel
style guide (the chosen style guide for util-linux) says no spaces are
allowed for c indentation, but Karel seems to make an exception for that.

I have git configured to highlight eight spaces and when I looked at
this commit with 'git show' that line lit up in red. Something I do
not normally see happen in this project.

> 
> cu,
> Rudi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
