Return-Path: linux-fsdevel-owner@vger.kernel.org
MIME-Version: 1.0
In-Reply-To: <20120224122755.GA2106@x2.net.home>
References: <20120224122755.GA2106@x2.net.home>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Fri, 24 Feb 2012 14:31:37 +0100
Message-ID: <CAGm1_ktDhLd=YCT+zfAjQPwTKH+NLGTwew4Wc42wnwLm00RVTw@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.21
To: Karel Zak <kzak@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

On Fri, Feb 24, 2012 at 1:27 PM, Karel Zak <kzak@redhat.com> wrote:
>
> The util-linux release v2.21 is available at
>
>  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.21
>
> Feedback and bug reports, as always, are welcomed.

You asked for it :-)

I tried to cross-compile the package under Buildroot and got following error:

checking whether __progname is defined... yes
checking whether the target supports thread-local storage... yes
configure: error: in `buildroot/output/build/util-linux-2.21':
configure: error: cannot run test program while cross compiling

Could you disable tests for cross-compilation case?

Regards,
Yegor
