Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36609 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDTVmi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Apr 2018 17:42:38 -0400
Received: by mail-pg0-f45.google.com with SMTP id i6so4542722pgv.3
        for <util-linux@vger.kernel.org>; Fri, 20 Apr 2018 14:42:38 -0700 (PDT)
Received: from [10.17.96.100] ([206.169.83.146])
        by smtp.gmail.com with ESMTPSA id d83sm18320208pfl.176.2018.04.20.14.42.35
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 14:42:36 -0700 (PDT)
To: util-linux@vger.kernel.org
From: Dan Mick <dmick@redhat.com>
Subject: lsblk '--allcols'
Message-ID: <cf949a43-9027-de52-87e2-33c95605d58b@redhat.com>
Date: Fri, 20 Apr 2018 14:42:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Beyond simple "show me a quick overview", I often want to see everything
the system knows about a blockdev, and it's a drag to have to construct
the option list from the output of help.  I've made a simple
"-A/--allcols" patch.  Is that something that would meet the
expectations of the team, and if so, is email to this list the best way
to submit it?
