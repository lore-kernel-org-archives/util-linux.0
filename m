Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57304 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbdHANEF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 09:04:05 -0400
Subject: Re: [PATCH 0/5] Pull Request
To: Karel Zak <kzak@redhat.com>
References: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
 <20170801095121.55s26xvmdoq4vfml@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <75bd90f4-a977-c767-5141-002092032b6b@gmx.com>
Date: Tue, 1 Aug 2017 09:03:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170801095121.55s26xvmdoq4vfml@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 08/01/2017 05:51 AM, Karel Zak wrote:
> On Mon, Jul 31, 2017 at 07:36:22PM -0400, J William Piggott wrote:
>>       hwclock: squash custom errno strings
>>       hwclock: squash custom errno strings
>>       hwclock: fix unimplemented ioctl test
>>       hwclock: remove custom errno string
>>       hwclock: remove custom errno string
> 
>  Cool, I like it a lot. This is exactly how error/warning messages
>  should be composed. Don't guess anything, don't try to explain
>  everything, etc ... just print errno based string.

Thanks for the feedback. I feel the same. hwclock messages editorialize
and are too verbose. There are more to fix on my todo list. The --systz
function has the "Don't guess anything" problem. It prints what it
expects the kernel to do as being fact.


> 
>  Applied, thanks.
> 
>     Karel
> 
