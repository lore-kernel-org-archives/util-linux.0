Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757104Ab2IDPSt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Sep 2012 11:18:49 -0400
Date: Tue, 4 Sep 2012 17:18:43 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Cc: Ludwig Nussel <ludwig.nussel@suse.de>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: runuser(1) and su(1) -g/-G
Message-ID: <20120904151843.GA6389@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

I did some changes to the su(1):

  - add --group= option to specify the primary group
  - add --supp-group= option to specify a supplemental group

the both options are based on Fedora runuser(1) patch and it's
available for root only (non-root cannot specify any groups).


I have also added new command runuser(1) -- it's completely based on
su(1) code. The difference is that runuser does not ask for password,
has to be executed by root and it uses different PAM configuration
(/etc/pam.d/runuser[-l]).

The changes should be available in v2.23 (or easily backported to
2.22, I'll do that for Fedora).

See master branch and "git whatchanged login-utils/".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
