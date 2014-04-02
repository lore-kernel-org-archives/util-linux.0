Return-Path: P@draigbrady.com
Message-ID: <533C021C.4060106@draigBrady.com>
Date: Wed, 02 Apr 2014 13:27:08 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
MIME-Version: 1.0
To: Lukas Czerner <lczerner@redhat.com>
CC: util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: [PATCH] fallocate: add FALLOC_FL_ZERO_RANGE support
References: <1396438265-21535-1-git-send-email-lczerner@redhat.com>
In-Reply-To: <1396438265-21535-1-git-send-email-lczerner@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 04/02/2014 12:31 PM, Lukas Czerner wrote:
> Recent Linux kernel supports FALLOC_FL_ZERO_RANGE in fallocate(2).
> This patch adds FALLOC_FL_ZERO_RANGE support to fallocate utility,
> by introducing a new option -z|--zero-range.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Looks good thanks.

I was wondering how this interacts with the --dig-holes option.
That looks for ranges of zeros as efficiently as possible to turn them into holes.
It uses SEEK_DATA for that, so I was wondering if these preallocated
ranges of zeroes are treated specially in that regard?
Note one could use fiemap to distinguish these ranges,
but it's buggy as one needs to sync the file before using it.

thanks,
Pádraig.
