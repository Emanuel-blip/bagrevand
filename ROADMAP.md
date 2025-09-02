# Bagnstall (bpm) – Roadmap

Այս փաստաթուղթը նկարագրում է մեր փաթեթային մենեջերի (bpm) զարգացման ուղին։ Այն բաժանված է փուլերի՝ սկսած հիմնական ֆունկցիոնալից մինչև ավելի առաջադեմ հնարավորություններ։  
Մեր նպատակը պարզ, հուսալի և ընդլայնվող package manager ստեղծելն է BagrevandOS-ի համար։

---

## 🟢 Stage 1 – Հիմնական (MVP)

**Նպատակ** – ունենալ աշխատող նվազագույն փաթեթային մենեջեր, որը կարող է տեղադրել պարզ scripts GitHub-ից։

- [x] **`install` command**  
  - Կարող է ներբեռնել package (script) GitHub repository-ից։  
  - Պահել այն `~/bagrevand_packages/<name>`-ում։  
  - Ավելացնել PATH-ի մեջ այնպես, որ հնարավոր լինի գործարկել անմիջապես անունով։  

- [ ] **`remove` command**  
  - Ջնջել տեղադրված package-ը։  
  - Հեռացնել PATH-ից symlink-ը։  

- [ ] **Հիմնական սխալների կառավարում**  
  - Ճիշտ error հաղորդագրություններ (օր. եթե package չկա repo-ում, կամ ֆայլը չի ներբեռնվել)։  

---

## 🟡 Stage 2 – Հարմարավետություն

**Նպատակ** – դարձնել bpm-ը օգտատիրոջ համար հարմար և ինտուիտիվ։  

- [ ] **`list` command**  
  - Ցուցադրել տեղադրված բոլոր package-ները։  

- [ ] **`search` command**  
  - Գտնել փաթեթներ GitHub repo-ում (սկզբում՝ պարզապես ցուցակել բոլոր հասանելի անունները)։  

- [ ] **`info` command**  
  - Ցուցադրել փաթեթի մասին մանրամասներ (օր. անուն, նկարագիր, version, dependencies)։  

- [ ] **Լավ CLI UI**  
  - Ավելի գեղեցիկ output (գույներ, warning/info/error հստակ)։  

---

## 🔵 Stage 3 – Dependency Management

**Նպատակ** – ապահովել փաթեթների կախվածությունների կառավարում։  

- [ ] **Dependencies support**  
  - Թույլ տալ, որ package-ը ունենա metadata (օրինակ՝ `package.yml` կամ `manifest.json`)։  
  - Մինչև տեղադրելը՝ ստուգել ու տեղադրել նաև անհրաժեշտ dependencies։  

- [ ] **Versioning**  
  - Հնարավորություն՝ նշել package-ի տարբերակը։  
  - Հաշվի առնել semver (օր. `>=1.0.0`)։  

- [ ] **Upgrade command (`bpm upgrade`)**  
  - Թարմացնել բոլոր կամ որոշակի package-ներ վերջին version-ին։  

---

## 🟣 Stage 4 – Advanced Features

**Նպատակ** – bpm-ը դարձնել լիարժեք package manager։  

- [ ] **Remove orphaned dependencies**  
  - Եթե package-ը ջնջվել է, և կախվածությունները այլևս չեն օգտագործվում՝ ջնջել։  

- [ ] **Cache system**  
  - Ներբեռնված փաթեթները պահել cache-ում, որպեսզի կրկին ներբեռնելու կարիք չլինի։  

- [ ] **Security checks**  
  - Hash (SHA256) ստուգում յուրաքանչյուր package-ի համար։  
  - SSL վավերացում (խուսափելու համար man-in-the-middle հարձակումներից)։  

- [ ] **Cross-platform support**  
  - Թույլ տալ աշխատել ոչ միայն Linux-ում, այլև BSD / Mac / նույնիսկ Windows Subsystem for Linux։  

---

## 🔴 Stage 5 – Community & Automation

**Նպատակ** – bpm-ը դարձնել համագործակցային և ավտոմատացված։  

- [ ] **Testing suite**  
  - Unit tests և integration tests բոլոր command-ների համար։  
  - `tests/` թղթապանակ։  

- [ ] **GitHub Actions integration**  
  - Ամեն commit-ի ժամանակ ավտոմատ build և test։  

- [ ] **Documentation site**  
  - Հստակ docs (օր. MkDocs կամ GitHub Pages)։  
  - Օգտագործման օրինակներ, developer guide։  

- [ ] **Contribution guide**  
  - CONTRIBUTING.md, coding style, branching workflow։  

---

## Եզրակացություն

Այս roadmap-ը նախատեսված է, որ bpm-ն աճի փոքր script installer-ից մինչև լիարժեք package manager։  
Յուրաքանչյուր փուլ ավարտելուց հետո կտեղափոխվենք հաջորդին։  


