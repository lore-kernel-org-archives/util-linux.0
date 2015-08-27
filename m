Return-Path: keescook@google.com
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20150827092646.GF2410@ws.net.home>
References: <20150826224923.GA11884@www.outflux.net>
	<20150827092646.GF2410@ws.net.home>
Date: Thu, 27 Aug 2015 10:01:57 -0700
Message-ID: <CAGXu5jLUVLu1awkSGQ2NLNpmzYJ9xo5H1zjzwC19Wo2o6d8FLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
From: Kees Cook <keescook@chromium.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 27, 2015 at 2:26 AM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Aug 26, 2015 at 03:49:23PM -0700, Kees Cook wrote:
>>  libmount/src/mountP.h    |  2 ++
>>  libmount/src/tab.c       |  1 +
>>  libmount/src/tab_parse.c | 19 +++++++++----------
>>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> I have applied a different version of the patch. See below. Thanks!
>
> It would be possible to use the new libmnt_parser on more places in
> the code, but we are in -rc2, so I don't want to be so invasive now.

This looks great, thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
