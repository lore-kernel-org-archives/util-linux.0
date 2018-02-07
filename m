Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753409AbeBGJrf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Feb 2018 04:47:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99AC67D679
        for <util-linux@vger.kernel.org>; Wed,  7 Feb 2018 09:47:34 +0000 (UTC)
Received: from ws.net.home (ovpn-117-78.ams2.redhat.com [10.36.117.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E972100857E
        for <util-linux@vger.kernel.org>; Wed,  7 Feb 2018 09:47:33 +0000 (UTC)
Date: Wed, 7 Feb 2018 10:47:31 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: ready for v2.32 ?
Message-ID: <20180207094731.cvuyp3txmcom3u3u@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 I'd like to release v2.32-rc1 on Friday (or Monday). Do you see any
 unwanted or missing patches in the master branch?

 For now the last missing thing is William's "calendar system header"
 option and switch for cal(1), but I think we can postpone this
 until v2.33. We have enough changes for cal(1) in v2.32 ;-)

 The regression tests improvements (for example faketime for cal(1))
 we can merge during -rc1.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
