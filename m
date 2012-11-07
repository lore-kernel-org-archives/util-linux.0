Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab2KGQ7D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Nov 2012 11:59:03 -0500
Date: Wed, 7 Nov 2012 17:58:59 +0100
From: Karel Zak <kzak@redhat.com>
To: "Dr. Werner Fink" <werner@suse.de>, util-linux@vger.kernel.org
Subject: agetty and special chars @ and #
Message-ID: <20121107165859.GD4383@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Werner,

 agetty in get_logname() interprets '@' and '#' as a special chars
 (see man page or the code for more details).

 The problem is that we already have crazy users who want to use AD
 (access domain) usernames in format user@domain on serial line or
 console.

 Yeah, I know that char '@' is not between allowed username chars
 (POSIX 3.429), but do we really need to support the spacial
 interpretation of the @ and # chars?

 I think it's old confusing legacy. Objections?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
