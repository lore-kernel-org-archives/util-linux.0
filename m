Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbdBAOqe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Feb 2017 09:46:34 -0500
Date: Wed, 1 Feb 2017 15:46:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Michal Soltys <soltys@ziu.info>
Cc: util-linux@vger.kernel.org
Subject: Re: findmnt under container
Message-ID: <20170201144623.5pvxhdfeyfwmhnrb@ws.net.home>
References: <008ff846-8010-44ef-2056-5e0ecdc355c1@ziu.info>
 <20170201114246.tpjirhsk52qaijuo@ws.net.home>
 <3716efe8-d5bd-c4af-4180-975fa3a112cb@ziu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3716efe8-d5bd-c4af-4180-975fa3a112cb@ziu.info>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 01, 2017 at 02:37:11PM +0100, Michal Soltys wrote:
> 220 189 8:3 /arch / rw,relatime shared:50 - ext4 /dev/sda3 rw
> 221 220 0:17 / /sys ro,nosuid,nodev,noexec,relatime shared:51 - sysfs sysfs rw
> 222 220 0:52 / /dev rw,nosuid shared:52 - tmpfs tmpfs rw,mode=755
> 223 222 0:53 / /dev/shm rw,nosuid,nodev shared:53 - tmpfs tmpfs rw
> 224 222 0:56 / /dev/pts rw,nosuid,noexec,relatime shared:56 - devpts devpts rw,gid=5,mode=620,ptmxmode=666
> 225 222 0:21 /5 /dev/console rw,nosuid,noexec,relatime shared:57 master:4 - devpts devpts rw,gid=5,mode=620,ptmxmode=000
> 226 220 0:54 / /run rw,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
> 227 226 0:18 /systemd/nspawn/propagate/arch /run/systemd/nspawn/incoming ro,relatime master:11 - tmpfs run rw,mode=755
> 228 220 0:55 / /tmp rw shared:55 - tmpfs tmpfs rw
> 231 220 0:58 / /proc rw,nosuid,nodev,noexec,relatime shared:58 - proc proc rw
> 232 231 0:58 /sys /proc/sys ro,nosuid,nodev,noexec,relatime shared:58 - proc proc rw
> 233 231 0:58 /sysrq-trigger /proc/sysrq-trigger ro,nosuid,nodev,noexec,relatime shared:58 - proc proc rw
> 93 221 0:59 / /sys/fs/cgroup ro,nosuid,nodev,noexec shared:59 - tmpfs tmpfs ro,mode=755
> 94 93 0:29 / /sys/fs/cgroup/perf_event ro,nosuid,nodev,noexec,relatime shared:60 - cgroup cgroup rw,perf_event
> 95 93 0:31 / /sys/fs/cgroup/net_cls ro,nosuid,nodev,noexec,relatime shared:61 - cgroup cgroup rw,net_cls
> 96 93 0:30 / /sys/fs/cgroup/blkio ro,nosuid,nodev,noexec,relatime shared:62 - cgroup cgroup rw,blkio
> 98 93 0:33 / /sys/fs/cgroup/memory ro,nosuid,nodev,noexec,relatime shared:63 - cgroup cgroup rw,memory
> 99 93 0:32 / /sys/fs/cgroup/pids ro,nosuid,nodev,noexec,relatime shared:64 - cgroup cgroup rw,pids
> 100 93 0:27 / /sys/fs/cgroup/cpuset ro,nosuid,nodev,noexec,relatime shared:65 - cgroup cgroup rw,cpuset
> 101 93 0:25 / /sys/fs/cgroup/freezer ro,nosuid,nodev,noexec,relatime shared:66 - cgroup cgroup rw,freezer
> 102 93 0:28 / /sys/fs/cgroup/cpu,cpuacct ro,nosuid,nodev,noexec,relatime shared:67 - cgroup cgroup rw,cpu,cpuacct
> 103 93 0:26 / /sys/fs/cgroup/devices ro,nosuid,nodev,noexec,relatime shared:68 - cgroup cgroup rw,devices
> 104 93 0:23 / /sys/fs/cgroup/systemd rw,nosuid,nodev,noexec,relatime shared:69 - cgroup cgroup rw,xattr,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd
> 105 232 0:54 /proc-sys-kernel-random-boot-id//deleted /proc/sys/kernel/random/boot_id ro,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
> 106 231 0:54 /proc-sys-kernel-random-boot-id//deleted /proc/sys/kernel/random/boot_id rw,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
> 107 231 0:54 /kmsg//deleted /proc/kmsg rw,nosuid,nodev shared:54 - tmpfs tmpfs rw,mode=755
> 97 222 0:57 / /dev/mqueue rw,relatime shared:70 - mqueue mqueue rw
> 108 222 0:60 / /dev/hugepages rw,relatime shared:71 - hugetlbfs hugetlbfs rw
> 109 226 0:61 / /run/user/0 rw,nosuid,nodev,relatime shared:72 - tmpfs tmpfs rw,size=1634120k,mode=700

The first column is mount ID and second is parent mount ID.

The findmnt uses these columns to compose the output tree. Unfortunately it
assumes that root FS has the smallest ID. That's not true in your container.
I'll try to fix it.

  findmnt --list

probably works as expected.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
