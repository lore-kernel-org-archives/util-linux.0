Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbdEQHrq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 May 2017 03:47:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 594AF8123A
        for <util-linux@vger.kernel.org>; Wed, 17 May 2017 07:47:46 +0000 (UTC)
Received: from ws.net.home (ovpn-117-204.ams2.redhat.com [10.36.117.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8897217AA5
        for <util-linux@vger.kernel.org>; Wed, 17 May 2017 07:47:44 +0000 (UTC)
Date: Wed, 17 May 2017 09:47:41 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: versioning
Message-ID: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 Sami has good point on IRC... do we really want to continue with the
 current versioning schema? Now we use:

    v2.xx[.y]

 I don't expect v3 or v4, so the prefix v2 does not provide any
 information... and the 'xx' ('30' now) is already large number. 

 Suggestions:

 1) do nothing; nobody cares and v2.31 looks good

 2) remove '2' from the version:

        major release:  v31
        update release: v31.1


 3) <your suggestion>?
 

 Note that for v2.30 is to late to do any change in version numbers
 (we need changes in our libraries and I have to update some my scripts).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
