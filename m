Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38311 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeDXViR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Apr 2018 17:38:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id h3-v6so51380518wrh.5
        for <util-linux@vger.kernel.org>; Tue, 24 Apr 2018 14:38:17 -0700 (PDT)
Date: Tue, 24 Apr 2018 22:38:02 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: Dan Mick <dmick@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: lsblk '--allcols'
In-Reply-To: <20180423094628.4x3qhf7ah5gazz7z@ws.net.home>
Message-ID: <alpine.LNX.2.20.1804242230510.12936@imuri>
References: <cf949a43-9027-de52-87e2-33c95605d58b@redhat.com> <CAG27Bk3m7PYCMtMMV0pVAZpmMJGsGWUk0KFfpT=KD80U4QQ5ug@mail.gmail.com> <20180423094628.4x3qhf7ah5gazz7z@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 23 Apr 2018, Karel Zak wrote:
> On Sat, Apr 21, 2018 at 09:14:03AM +0100, Sami Kerola wrote:
> > If I see right the --output-all could be added to these utilities: fdisk,
> > fincore, findmnt, losetup, lscpu, lsipc, lslocks, lslogins, lsmem, lsns,
> > partx, prlimit, rfkill, sfdisk, swapon, uuidparse, wdctl, wipefs, and
> > zramctl.
> 
> Good idea. (Your) patches are welcomed :-)

Here's some.  I skipped couple commands, they either already listing all 
columns or are unlikely to be used for info listing (fdisk, wipefs, ...)

Due the tiring repetativeness in these changes I won't send send these to 
maillist. Please fetch from my remote to review & merge.

----------------------------------------------------------------
The following changes since commit 136f89ce5ed8cd159a1c56b5a775dada2363ecd3:
  libblkid: add BitLocker detection (2018-04-24 11:47:55 +0200)
are available in the Git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git output-all
for you to fetch changes up to 9c1bbbf41bc82aa94e93703af19d459092a728ed:
  zramctl: add --output-all option (2018-04-24 22:28:41 +0100)
----------------------------------------------------------------

Sami Kerola (11):
      findmnt: add --output-all option
      losetup: add --output-all option
      lscpu: add --output-all option
      lslocks: add --output-all option
      lslogins: add --output-all option
      lsmem: add --output-all option
      lsns: add --output-all option
      partx: add --output-all option
      rfkill: add --output-all option
      swapon: add --output-all option
      zramctl: add --output-all option

 bash-completion/findmnt  |  1 +
 bash-completion/losetup  |  1 +
 bash-completion/lscpu    |  1 +
 bash-completion/lslocks  |  1 +
 bash-completion/lslogins |  1 +
 bash-completion/lsmem    |  1 +
 bash-completion/lsns     |  1 +
 bash-completion/partx    |  1 +
 bash-completion/rfkill   |  1 +
 bash-completion/swapon   |  1 +
 bash-completion/zramctl  |  1 +
 disk-utils/partx.8       |  3 +++
 disk-utils/partx.c       |  9 ++++++++-
 login-utils/lslogins.1   |  3 +++
 login-utils/lslogins.c   |  7 +++++++
 misc-utils/findmnt.8     |  5 +++++
 misc-utils/findmnt.c     | 12 +++++++++++-
 misc-utils/lslocks.8     |  3 +++
 misc-utils/lslocks.c     |  9 +++++++++
 sys-utils/losetup.8      |  3 +++
 sys-utils/losetup.c      |  9 ++++++++-
 sys-utils/lscpu.1        |  4 ++++
 sys-utils/lscpu.c        | 11 +++++++++++
 sys-utils/lsmem.1        |  3 +++
 sys-utils/lsmem.c        |  9 ++++++++-
 sys-utils/lsns.8         |  3 +++
 sys-utils/lsns.c         |  9 +++++++++
 sys-utils/rfkill.8       |  3 +++
 sys-utils/rfkill.c       | 12 +++++++++++-
 sys-utils/swapon.8       |  3 +++
 sys-utils/swapon.c       |  8 +++++++-
 sys-utils/zramctl.8      |  3 +++
 sys-utils/zramctl.c      | 11 ++++++++++-
 33 files changed, 146 insertions(+), 7 deletions(-)

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
