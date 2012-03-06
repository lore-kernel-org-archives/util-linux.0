Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15903 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873Ab2CFQQT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Mar 2012 11:16:19 -0500
Date: Tue, 6 Mar 2012 17:16:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dbueso@aomail.uab.es>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lslocks: add personality column
Message-ID: <20120306161613.GC8389@x2.net.home>
References: <1330693206.23371.0.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330693206.23371.0.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 02, 2012 at 02:00:06PM +0100, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> 
> By knowing the lock's personality (flock or posix), the user can have more information
> about the lock and how it was created.
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  misc-utils/lslocks.8 |    5 +++++
>  misc-utils/lslocks.c |   30 ++++++++++++++++++++----------
>  2 files changed, 25 insertions(+), 10 deletions(-)

 Applied with some changes:

    - rename ACCESS to MODE
    - rename PERSONALITY to TYPE (the column name was too long)
    - fix the typos and missing break
    - rename struct lock members to match with column names

 See below. Thanks!

    Karel

$ lslocks 
COMMAND           PID  TYPE SIZE MODE  M      START                 END PATH
libvirtd         1243 POSIX   0B WRITE 0          0                   0 /run
(unknown)        1283 FLOCK   0B WRITE 0          0                   0 /run
tracker-store    1974 POSIX 5.3M READ  0 1073741826          1073742335 /home/kz
tracker-store    1974 POSIX  32K READ  0        128                 128 /home/kz
tracker-miner-f  1975 POSIX 5.3M READ  0 1073741826          1073742335 /home/kz
tracker-miner-f  1975 POSIX  32K READ  0        128                 128 /home/kz
java            11500 POSIX   0B WRITE 0          0 9223372036854775806 /home/kz
firefox          8976 POSIX   0B WRITE 0          0                   0 /home/kz
firefox          8976 POSIX 384K WRITE 0 1073741824          1073742335 /home/kz
firefox          8976 POSIX 1.5M READ  0 1073741826          1073742335 /home/kz
firefox          8976 POSIX  32K READ  0        128                 128 /home/kz
firefox          8976 POSIX 416K WRITE 0 1073741824          1073742335 /home/kz
firefox          8976 POSIX  20M READ  0 1073741826          1073742335 /home/kz
firefox          8976 POSIX  32K READ  0        128                 128 /home/kz
crond           17793 POSIX   0B WRITE 0          0                   0 /run
atd             24371 POSIX   0B WRITE 0          0                   0 /run



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
