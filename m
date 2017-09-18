Return-Path: sweet_f_a@gmx.de
Subject: Re: [PATCH 2/3] tools: update git-version-gen from gnulib
To: Karel Zak <kzak@redhat.com>, Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20170917184902.1218-1-kerolasa@iki.fi>
 <20170917184902.1218-2-kerolasa@iki.fi>
 <20170918090755.mxogoxmodbq2hlzp@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <00f84d55-932f-854f-2492-f77e119913e2@gmx.de>
Date: Mon, 18 Sep 2017 15:36:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170918090755.mxogoxmodbq2hlzp@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <util-linux.vger.kernel.org>



On 09/18/2017 11:07 AM, Karel Zak wrote:
> On Sun, Sep 17, 2017 at 07:49:01PM +0100, Sami Kerola wrote:
>> from-gnulib-commit: e277cd7c6cf6435d9d4d380fd6cef0510e3f5afe
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>   tools/git-version-gen | 137 +++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 102 insertions(+), 35 deletions(-)
> 
> I'm not sure about this. Did you check all the changes?
> 
> We have some local changes to the file, see
> 
>      git whatchanged tools/git-version-gen
>      
> It would be nice to be sure that all works as expected.

I wouldn't touch this neither. Last year I've reviewed that really carefully
while fixing some issues with broken version numbers, see 85004b14 and also
the other ones from the same patch-set. Seems that Sami's patch would revert
some of these changes.

At that time there was also the question why not following gnulib and I tried to
justify this like this:

https://www.spinics.net/lists/util-linux-ng/msg13374.html

cu,
Rudi
