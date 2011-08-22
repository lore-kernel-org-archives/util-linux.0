Return-Path: giulioo@gmail.com
From: Giulio Orsero <giulioo@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: make some tests conditional to !Linux
Date: Mon, 22 Aug 2011 20:45:47 +0200
Reply-To: giulioo@pobox.com
References: <20110818073019.B70AFF815@i3.golden.dom> <20110822083206.GA20457@nb.net.home>
In-Reply-To: <20110822083206.GA20457@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20110822184546.8D6F9F815@i3.golden.dom>
List-ID: <util-linux.vger.kernel.org>

On Mon, 22 Aug 2011 10:32:06 +0200, Karel Zak <kzak@redhat.com> wrote:

>On Thu, Aug 18, 2011 at 09:30:30AM +0200, Giulio wrote:
>> +	    if (!chs_ok(b, PNO(p), _("start")) && !Linux)
>[...]
>> +	    if (!chs_ok(b, PNO(p), _("end")) && !Linux)
>would be better to use
>    if (!Linux && chs_ok(b, PNO(p), ....)
>so the chs_ok() will not called on Linux at all?

Maybe the compiler reordered it since it didn't print those messages =
anymore
anyway; for clarity I redordered the tests.
