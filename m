Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbaCKJwt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Mar 2014 05:52:49 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2B9qneS032020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 11 Mar 2014 05:52:49 -0400
Date: Tue, 11 Mar 2014 10:52:47 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Ondrej Oprala <ooprala@redhat.com>
Subject: /etc/terminal-colors.d
Message-ID: <20140311095247.GI9303@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



 Hi,

as already discussed we need a way how to control colorized output
(ideally something better than shell alias or env.variables).

I have merged support for

  /etc/terminal-colors.d/disable
  /etc/terminal-colors.d/<name>.disable
  /etc/terminal-colors.d/<name>.enable

where the <name> is util name (e.g. "dmesg"). The colors for all utils
are enabled for now.


The next step will be (probably) to support color scheme setting by

  /etc/terminal-colors.d/<name>.colors

in the same way how coreutils specifies dir_colors.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
