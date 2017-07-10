Return-Path: elseifthen@gmx.com
Subject: [PING - REBASED][PATCH 0/5] pull request
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <36c342d3-ec59-59fe-f98e-233d72696d84@gmx.com>
Date: Mon, 10 Jul 2017 19:34:55 -0400
MIME-Version: 1.0
In-Reply-To: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 07/02/2017 03:45 PM, J William Piggott wrote:
> 
> The following changes since commit 07fd6640c80ffd7a2067844aadcb6162431b3525:
> 
>   Merge branch 'path-fixes' of https://github.com/rudimeier/util-linux (2017-06-29 15:29:33 +0200)
> 
> are available in the git repository at:
> 
>   git@github.com:jwpi/util-linux.git 170701
> 
> for you to fetch changes up to 9c50e384c89d5f9391c3eaed8df89ec965f2fda7:
> 
>   hwclock: sync one-liner descriptions (2017-07-02 14:09:41 -0400)
> 
> ----------------------------------------------------------------
> J William Piggott (5):
>       hwclock: remove from usage() FILE *out = stdout
>       hwclock: usage() use program_invocation_short_name
>       hwclock: final usage() strings slice
>       docs: update boilerplate.c usage()
>       hwclock: sync one-liner descriptions
> 
>  Documentation/boilerplate.c | 37 ++++++++++++------------
>  sys-utils/hwclock.8.in      |  4 +--
>  sys-utils/hwclock.c         | 68 +++++++++++++++++++++++----------------------
>  3 files changed, 55 insertions(+), 54 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
