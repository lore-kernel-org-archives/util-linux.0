Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50728 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356AbbBBAVS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 1 Feb 2015 19:21:18 -0500
Message-ID: <54CEC2F3.7060906@gmx.com>
Date: Sun, 01 Feb 2015 19:21:07 -0500
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Peter Cordes <peter@cordes.ca>
CC: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] docs: add the Sort command to the man page of	cfdisk
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net> <1422799213-16717-8-git-send-email-bensberg@justemail.net> <54CE80A2.1040008@gmx.com> <20150201212138.GV29504@cordes.ca>
In-Reply-To: <20150201212138.GV29504@cordes.ca>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 02/01/2015 04:21 PM, Peter Cordes wrote:
> On Sun, Feb 01, 2015 at 02:38:10PM -0500, J William Piggott wrote:
>>
>>
>> On 02/01/2015 09:00 AM, Benno Schulenberg wrote:
>>> Also sort T into its proper position, improve the wording of U,
>>> and add the Left and Right arrow keys.
>>>
>>> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
>>> ---
>>>  disk-utils/cfdisk.8 |   38 +++++++++++++++++++++++---------------
>>>  1 files changed, 23 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
>>> index dc30b70..e4577d5 100644
>>> --- a/disk-utils/cfdisk.8
>>> +++ b/disk-utils/cfdisk.8
> ...
>>>  .PP
>>>  All commands can be entered with either uppercase or lowercase
>>>  letters (except for
>>>  .BR W rite).
>>> -When in a submenu or at a prompt for entering a size, you can hit the
>>> -.I ESC
>>> +When in a submenu or at a prompt, you can hit the
>>> +.I Esc
>>>  key to return to the main menu.
>>
>> s/can hit/may use/
> 
>  I think "can" is better.  "can use", though, rather than "can hit".
> There's a "can be entered" earlier in the paragraph, which I think is
> good usage.
> 
> "may" sounds like either the docs / software is giving you permission
> to use this feature,

Yes, that is exactly why 'may' is better. One 'can' use the <ESC>
anytime, I'm hitting it right now. Can means: it is possible.

What is being said, is in this particular circumstance the program
'allows' you to use that key and something will happen.

Having said that, grammatically either one is considered acceptable.
So 'can vs may' is a subjective call, but 'hit' needs to go IMO.


> or commenting on whether or not you might
> actually use the feature.
> 
> 
>  Docs should get their meaning across with as simple and
> straightforward language as possible, for quick reading and
> understanding by as many people as possible.  And hopefully not
> distract ADHD people like me into thinking about re-wording them while
> I'm in the middle of trying to figure out how to do something else :P.
> 
