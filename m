Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbeIDOGU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Sep 2018 10:06:20 -0400
Date: Tue, 4 Sep 2018 11:41:58 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: RFD: --enable-bindir-path ?
Message-ID: <20180904094158.6m2wxi22ulrlga4h@ws.net.home>
References: <5B82E969.6090409@tlinx.org>
 <20180830084556.ubvu5e5qhzih5fng@ws.net.home>
 <5B89C74D.8030701@tlinx.org>
 <20180903101725.ngjabihabq2n6oeg@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180903101725.ngjabihabq2n6oeg@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 03, 2018 at 12:17:25PM +0200, Karel Zak wrote:
>  $ ./configure --disable-makeinstall-chown --disable-makeinstall-setuid --libdir=/lib

I did a small improvement for systems where the default is /lib64, so
now --libdir=/lib should be unnecessary to install to /bin and /lib if
you follow the default settings.

Note that if you set --prefix or change any default setting than is
probably better to explicitly specify all the directories. For example
on Fedora we use

  ./configure --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu \
              --program-prefix= --disable-dependency-tracking --prefix=/usr \
              --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin \
              --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include \
              --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var \
              --sharedstatedir=/var/lib --mandir=/usr/share/man \
              --infodir=/usr/share/info --disable-assert \
              --with-systemdsystemunitdir=/usr/lib/systemd/system \
              --disable-silent-rules --disable-bfs --disable-pg --enable-chfn-chsh \
              --enable-usrdir-path --enable-write --enable-raw --with-python=3 \
              --with-systemd --with-udev --with-selinux --with-audit --with-utempter \
              --disable-makeinstall-chown

to get full control.

The option --enable-usrdir-path has been introduced to get proper $PATH.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
