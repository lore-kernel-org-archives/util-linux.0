Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762667AbdDSLey (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 19 Apr 2017 07:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 348898050D
        for <util-linux@vger.kernel.org>; Wed, 19 Apr 2017 11:34:48 +0000 (UTC)
Received: from ws.net.home (ovpn-117-103.ams2.redhat.com [10.36.117.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F75F80F93
        for <util-linux@vger.kernel.org>; Wed, 19 Apr 2017 11:34:47 +0000 (UTC)
Date: Wed, 19 Apr 2017 13:34:44 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: column --table based on libsmartcols
Message-ID: <20170419113444.qfgmhgocuavp43id@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi all,

 I worked on new column(8) --table implementation last weeks. The
 result is available in my "column" branch

    https://github.com/karelzak/util-linux/commits/column

 The idea is to use "column --table" as command line interface to
 libsmartcols features. All the changes should be backwardly
 compatible, the non-table modes (fillrows and fillcols) are not
 affected at all.

 Features:

  * column headers
  * support text alignment to the right
  * support multi-line cells (wrap text in cells)
  * support text truncation
  * hide specified columns
  * reorder columns (IMHO unique feature)
  * JSON output
  * tree support

 New options:

 -n, --table-name <name>          table name for JSON output
 -O, --table-order <columns>      specify order of output columns
 -N, --table-columns <names>      comma separated columns names
 -E, --table-noextreme <columns>  don't count long text from the columns to column width
 -H, --table-hide <columns>       don't print the columns
 -R, --table-right <columns>      right align text in these columns
 -T, --table-truncate <columns>   truncate text in the columns when necessary
 -W, --table-wrap <columns>       wrap text in the columns when necessary
 -J, --json                       use JSON output format for table
 -r, --tree <column>              column to use tree-like output for the table
 -i, --tree-id <column>           line ID to specify child-parent relation
 -p, --tree-parent <column>       parent to specify child-parent relation


 Overkill or useful? ;-)

    Karel

    
 Examples

pstree-like output:

 $ ps -h -o pid,ppid,comm | column --table --tree 3 --tree-id 1 --tree-parent 2 --table-hide 2 --table-right 1

 1799  bash
 2254  bash
28427  └─mutt
 4263    └─vim
 7409  bash
10641  └─man
10657    └─less
16775  bash
11486  ├─ps
11487  └─column


 diskstat:

 $ column /proc/diskstats --table --table-columns MAJ,MIN,NAME,READ-COMP,READ-MERG,READ-SECS,READ-TIME,WRITE-COMP,WRITE-MERG,WRITE-SECS,WRITE-TIME,IO-CURR,IO-TIME,WTIME \
      --table-hide MAJ,MIN \
      --table-right 4,5,6,7,8,9,10,11,12,13,14 \

NAME   READ-COMP  READ-MERG   READ-SECS  READ-TIME  WRITE-COMP  WRITE-MERG  WRITE-SECS  WRITE-TIME  IO-CURR   IO-TIME      WTIME
sda     13486466     149085  1288469300    9715620    45556082     7788088  1600182109   150180178        0  12935701  159902109
sda1         463        170       19002        131          91           0         161         331        0       334        462
sda2         778         16       63140        276         434         261      507574       12616        0      2382      12889
sda3    10710224     109592  1052352266    8018950    43983768     7022717  1153182094   126210185        0  11002854  134299501
sda4     1630396      32476    67166050    1039837     1197142      665798   343331344    23264993        0   2148041   24306932
sda5     1140435        241   168747746     655625      225373       73891   102920032      637906        0    627834    1293105
sda6        3703       6590       99512        691        4691       25421      240904        8418        0      6402       9108
sdb          448          0       22506       3088        1887           4         128         275        0      1449       3363
sdb1         404          0       19370       3035          12           4         128          60        0      1187       3095
loop0      22086          0      347311       2025       10738           0      844888        2226        0      1129       4265
loop1        947          0       26940        325        1100           0      133316         734        0       411       1058
md8            0          0           0          0           0           0           0           0        0         0          0


 JSON:

 $ grep -v nologin /etc/passwd | column --separator : --table --table-name passwd --json \
                                        --table-columns USERNAME,PWD,UID,GID,GECOS,HOME,SHELL \
                                        --table-hide PWD
{
   "passwd": [
      {"username": "root", "uid": "0", "gid": "0", "gecos": "root", "home": "/root", "shell": "/bin/bash"},
      {"username": "sync", "uid": "5", "gid": "0", "gecos": "sync", "home": "/sbin", "shell": "/bin/sync"},
      {"username": "shutdown", "uid": "6", "gid": "0", "gecos": "shutdown", "home": "/sbin", "shell": "/sbin/shutdown"},
      {"username": "halt", "uid": "7", "gid": "0", "gecos": "halt", "home": "/sbin", "shell": "/sbin/halt"},
      {"username": "kzak", "uid": "1000", "gid": "1000", "gecos": "Karel Zak,Home,,,", "home": "/home/kzak", "shell": "/bin/bash"},
      {"username": "gamer", "uid": "1001", "gid": "1001", "gecos": null, "home": "/home/gamer", "shell": "/bin/bash"},
      {"username": "test", "uid": "1002", "gid": "1002", "gecos": null, "home": "/home/test", "shell": "/bin/bash"}
   ]
}


findmnt-like output:

 $ column /proc/self/mountinfo \
     --table-columns ID,PARENT,MAJMIN,ROOT,TARGET,VFS-OPTS,PROP,SEP,TYPE,SOURCE,FS-OPTS \
     --table-hide=SEP,ID,PARENT,ROOT,PROP,FS-OPTS,MAJMIN \
     --table-order TARGET,SOURCE,TYPE,VFS-OPTS \
     --tree TARGET \
     --tree-id ID \
     --tree-parent PARENT

TARGET                                 SOURCE                TYPE             VFS-OPTS
/                                      /dev/sda4             ext4             rw,relatime
├─/sys                                 sysfs                 sysfs            rw,nosuid,nodev,noexec,relatime
│ ├─/sys/kernel/security               securityfs            securityfs       rw,nosuid,nodev,noexec,relatime
│ ├─/sys/fs/cgroup                     tmpfs                 tmpfs            ro,nosuid,nodev,noexec
│ │ ├─/sys/fs/cgroup/systemd           cgroup                cgroup           rw,nosuid,nodev,noexec,relatime
│ │ ├─/sys/fs/cgroup/blkio             cgroup                cgroup           rw,nosuid,nodev,noexec,relatime
│ │ ├─/sys/fs/cgroup/cpu,cpuacct       cgroup                cgroup           rw,nosuid,nodev,noexec,relatime
│ │ ├─/sys/fs/cgroup/devices           cgroup                cgroup           rw,nosuid,nodev,noexec,relatime
│ │ ├─/sys/fs/cgroup/hugetlb           cgroup                cgroup           rw,nosuid,nodev,noexec,relatime
│ │ ├─/sys/fs/cgroup/pids              cgroup                cgroup           rw,nosuid,nodev,noexec,relatime
│ │ ├─/sys/fs/cgroup/memory            cgroup                cgroup           rw,nosuid,nodev,noexec,relatime
│ │ ├─/sys/fs/cgroup/cpuset            cgroup                cgroup           rw,nosuid,nodev,noexec,relatime

<...and so on...>


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
