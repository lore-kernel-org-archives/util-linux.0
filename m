Return-Path: lkml@tlinx.org
Message-ID: <5B91E7EB.3040006@tlinx.org>
Date: Thu, 06 Sep 2018 19:52:27 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: RFD: --enable-bindir-path ?
References: <5B82E969.6090409@tlinx.org> <20180830084556.ubvu5e5qhzih5fng@ws.net.home> <5B89C74D.8030701@tlinx.org> <20180903101725.ngjabihabq2n6oeg@ws.net.home> <20180904094158.6m2wxi22ulrlga4h@ws.net.home>
In-Reply-To: <20180904094158.6m2wxi22ulrlga4h@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 9/4/2018 2:41 AM, Karel Zak wrote:

Yeah, configure can be so tedious to use sometimes.
I set basic locations and the call common scripts to propagate settings
as defined in configure.  So specific tools will get some
specific paths, and I try to ensure the rest are set
accordingly. 
I try to default a bunch but based on previous settings, like (very
truncated list):

: ${exec_prefix:=${eprefix}}
: ${bits:=64}
: ${bindir=${eprefix}bin}
...
: ${localstatedir:=${prefix}var}
: ${includedir:=${exec_prefix}include}


Finally..I expand all the path stuff if the
associated var is set

declare -a path_ops=(
        ${prefix:+--prefix=$prefix}
        ${exec_prefix:+--exec-prefix=$exec_prefix}
        ${sharedstatedir:+--sharedstatedir=$sharedstatedir}
        ${sysconfdir:+--sysconfdir=$sysconfdir}
    )

Result is almost all of the paths being set...
I keep all the above in a common location.

For all the option toggling, I use 4 arrays:
    enable, disable, with and without, like:

declare -a enable=( readline select single-help-strings )
declare -a disable=(nls  )
declare -a with=( gnu-ld )
declare -a without=()

then below (config_ops already has path_ops rolled in):

for action in enable disable with without; do
  for op in $(eval echo "\${$action[@]}") ; do
    config_ops+=( $(echo "--$action-$op") )
  done
done

anyway -- some Q's on the versioning, but separate email...
