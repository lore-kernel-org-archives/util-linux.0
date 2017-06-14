Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751875AbdFNKaF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Jun 2017 06:30:05 -0400
Date: Wed, 14 Jun 2017 12:30:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/11] pull: various small changes
Message-ID: <20170614103001.hjkkffrliufwo6ms@ws.net.home>
References: <20170608195215.1702-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 08, 2017 at 08:52:04PM +0100, Sami Kerola wrote:
>   misc: fallthrough fixes

Fixed by patches from Rudi.

>   line: do not print new line if nothing else was printed
>   rename: notice when expression and replacement are the same string
>   uuidgen: slice up the usage text

Applied.

>   uuidgen: add --date option to display time when uuid was generated

Not applied, "uuidparse" suggested.

>   isosize: avoid reading more data than what is needed
>   misc: fix reassigned values before old ones has been used [cppcheck]
>   losetup: add missing initializer [clang]
>   misc: remove stray semicolons
>   lib: simplify cpuset if clauses that return
>   lib: remove _RLD_ from forbid environment variable list

Applied, thanks.

Please, don't add new features to cleanup pull requests, and always
use separate pull request for stuff you're not sure with it :)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
