Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbcJTQkR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 12:40:17 -0400
Date: Thu, 20 Oct 2016 18:40:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161020164016.olhnllmvwixbvzc4@ws.net.home>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <201610201334.24945.sweet_f_a@gmx.de>
 <20161020151948.3y47rv5lwmqppubf@ws.net.home>
 <201610201828.05511.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610201828.05511.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 20, 2016 at 06:28:05PM +0200, Ruediger Meier wrote:
> We don't need to handle such broken installation. In drone.io script you 
> could try
>   apt-get install -qq libncursesw5-dev

We call travis-functions.sh from drone.io, something like:

diff --git a/.travis-functions.sh b/.travis-functions.sh
index 6fcf019..3766534 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -95,6 +95,14 @@ function travis_install_script
 		libsystemd-daemon-dev \
 		libsystemd-journal-dev \
 		|| true
+
+	# install only if available
+	sudo apt-get install -qq >/dev/null \
+		libncursesw6-dev \
+		|| sudo apt-get install -qq >/dev/null \
+			libncursesw5-dev \
+			|| true
+
 }
 
 function osx_install_script


.. I guess we prefer ncurses6. Or it's too crazy? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
