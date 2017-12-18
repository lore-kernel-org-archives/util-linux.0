Return-Path: elseifthen@gmx.com
Subject: Re: Fixes for commit 3c49b23
To: Karel Zak <kzak@redhat.com>
References: <72856395-656c-b67d-1b28-f121e3f05b11@gmx.com>
 <20171218114920.b23vqpbmvqawlv5y@ws.net.home>
Cc: util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <99c74bd8-e951-bf73-d422-9de2841913a9@gmx.com>
Date: Mon, 18 Dec 2017 13:02:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171218114920.b23vqpbmvqawlv5y@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 12/18/2017 06:49 AM, Karel Zak wrote:
> On Sun, Dec 17, 2017 at 07:47:49PM -0500, J William Piggott wrote:


>>
>> On a somewhat related note, multi-byte characters are also making it
>> into the commit log; it's not a big deal I suppose, but it sure makes a
>> mess for systems that don't support them.
> 
> Well, it's too late, and I think commit messages is not so big issue :-)

Ha, I wasn't suggesting amending the entire commit log ;). I was hoping perhaps
it could be avoided in future commits. It appears to mostly be caused by
copy/paste there also. For example:

 ---

commit b9e4ee42c285e73b36879a96b9cde43edb0f90c6
Author: Karel Zak <kzak@redhat.com>
Date:   Tue Nov 28 10:53:35 2017 +0100

    nsenter: fix compiler warning [-Wuninitialized]
    
    sys-utils/nsenter.c: In function â<80><98>is_same_namespaceâ<80><99>:
    sys-utils/nsenter.c:170:2: warning: â<80><98>b_inoâ<80><99> may be used uninitialized in this function [-Wuninitialized]
    sys-utils/nsenter.c:170:2: warning: â<80><98>a_inoâ<80><99> may be used uninitialized in this function [-Wuninitialized]
    
    Signed-off-by: Karel Zak <kzak@redhat.com>

 ---

Looks like copy/paste from a terminal. Maybe there is no easy way to avoid
that? Would setting LANG=C when running the command due it? Maybe even that is
too much hassle.

Anyway, as we've both said, it's not a big deal. It just looks ugly.



> 
> Applied, thanks!
> 
>     Karel
> 
>>
>>
>>
>>
> 
