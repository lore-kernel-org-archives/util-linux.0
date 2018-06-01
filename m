Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751350AbeFALiL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 1 Jun 2018 07:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7ACCC12A1
        for <util-linux@vger.kernel.org>; Fri,  1 Jun 2018 11:38:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.118.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A7551C668
        for <util-linux@vger.kernel.org>; Fri,  1 Jun 2018 11:38:10 +0000 (UTC)
Date: Fri, 1 Jun 2018 13:38:07 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: hardlink util -- files de-duplication
Message-ID: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


For last 17 years in Red Hat based distros is available hardlink(1)
util, man hardlink:

   hardlink traverses one or more directories searching for duplicate
   files.  When it finds duplicate files, it uses one of them as the
   master.  It then removes all other duplicates and places a hardlink
   for each one pointing to the master file.  This allows for
   conservation of disk space where multiple directories on a single
   filesystem contain many  dupli‐ cate files.

   ...

the util is little bit orphaned, what about to add this util to
util-linux to make it available for another distros and keep it
maintained in serious way? ;-)

   https://src.fedoraproject.org/cgit/rpms/hardlink.git/

It's one .c file.

Comments & objections?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
