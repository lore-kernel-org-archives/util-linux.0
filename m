Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FD5C433EF
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 18:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhKXS3m (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhKXS3l (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Nov 2021 13:29:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB85C061574
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:31 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t11so3621100qtw.3
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tWugLfi7qHLjlCAPGXIqGUAo9+8iF7KmBdDlWECRSk=;
        b=SlvWTsHWsTG37NqC3mFqXRtI+y9Wmc/New6MyAlGdHj9nn3QTOMtSGzGTN2hzFB6Zk
         6t1DwKP48/AUIxtqO/4WyOC7JbblvgK2g/WEgS5Si/vxGLr5/+cJ4j1kOwvvz1qQ+Tpj
         W5b0/ABbGW8GtxcOVFErsHMLlz+8l5y5aZ3CKPKUuNFna63lq2ikjPiaxf/k31dBwc2p
         qlvrB9/arCdak/EnRv4n/d0lduecDecEhgvQT+3JL5DYdyO/CW4Vekhrt7vWIpYo/4oX
         tB8Hr23GlDS5pR9iSQyMv3bLwNyzdhxrXflP3NJiZ/zTirZVry8umeScy+mR1ulnyXox
         HlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tWugLfi7qHLjlCAPGXIqGUAo9+8iF7KmBdDlWECRSk=;
        b=BETkyjyIkgiD/IGMGRnIxrTQcrSLoJT3KlRjXaafyB/GIQSQBbZin/veqPEThGZI5z
         +F7MY7BbmX+aGPS0+wR3f4mdNSt9JrPSTity78L/3RuVHxVMsfY5SRy0rmwB7W6b6Z8I
         Ox0tyXwac+WN5Fw/KKzbfjElZBVGj6j3FeMte+hCWOQoSz8IZelNX5QOU92YvwbI6jK6
         fW+QVVmdZzYqd+6xMuJQwZz1ovykIO4BCsvLAISVd53StSeFiUk2f+O7hJRnSKIX80kh
         g2mR2shBQ7VrYeKlnvw1jRGsjfg2DUp0+YEtcvQvG05KWAXjVX/ZFIVGubKsvlzwGjT7
         otxQ==
X-Gm-Message-State: AOAM531pXIir2/ESKZL27/KMYJuUr00k5b6v41/0TShL0PncI8vI1gdM
        dsOlC4iELRzqMMNMlg3bjMn043xnxfw=
X-Google-Smtp-Source: ABdhPJxAZDXDFVUVdJPEYc4wSs0grPvmK5CdKLzjtluYIq1IW8K256OCC4TVNTvRVAobDjxTP2K7Zw==
X-Received: by 2002:a05:622a:14d2:: with SMTP id u18mr10108444qtx.219.1637778390421;
        Wed, 24 Nov 2021 10:26:30 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id h19sm274936qth.63.2021.11.24.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:26:30 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 0/6] unshare: Add support for mapping ranges of user/group IDs
Date:   Wed, 24 Nov 2021 13:26:12 -0500
Message-Id: <20211124182618.1801447-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This series adds support for mapping ranges of user/group IDs using the
newuidmap and newgidmap programs from shadow. The intent is to allow
for root-less bootstrapping of Linux root filesystems with correct
ownership. My primary inspiration is mmdebstrap [1], which uses
unshare(2) to create Debian root filesystems without needing root
access.

[1] https://gitlab.mister-muffin.de/josch/mmdebstrap

Changes in v2:
- Add "auto" option for --map-users and --map-groups
- Add UID_BUFSIZ macro to hold the maximum size of a uid represented as
  a string
- Add some documentation for waitchild
- Add some helpers for forking and synchronizing
- Copy names from string_to_idarray into a buffer to add a
  nul-terminator, instead of modifying them directly
- Document new "auto" value for --map-user and --map-group
- Fix most of read_subid_range using spaces instead of tabs
- Fix typo of --group instead of --user
- Update doc comments for uint_to_id() and get_map_range()
- Use more meaningful numbers in map_ids
- Use pathname macros for /etc/sub{u,g}id
- Use sync helpers for idmap

Sean Anderson (6):
  include/c: Add abs_diff macro
  unshare: Add waitchild helper
  unshare: Add some helpers for forking and synchronizing
  unshare: Add options to map blocks of user/group IDs
  unshare: Add option to automatically create user and group maps
  unshare: Document --map-{groups,users,auto}

 include/c.h              |   8 +
 include/pathnames.h      |   3 +
 sys-utils/unshare.1.adoc |  32 +++
 sys-utils/unshare.c      | 477 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 465 insertions(+), 55 deletions(-)

-- 
2.33.0

